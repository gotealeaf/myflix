require 'spec_helper'

describe User do
  it { should have_many(              :queue_items ).order("position"       )}
  it { should have_many(              :reviews     ).order("created_at DESC")}
  it { should validate_uniqueness_of( :email       )}
  it { should validate_presence_of(   :email       )}
  it { should validate_presence_of(   :name        )}
  it { should validate_presence_of(   :password    )}

  let(:joe) { User.new(name: "Joe", email: "joe@email.com", password: "foobar") }


  it "with proper attributes is valid" do
    expect(joe).to be_valid
  end
  it "should create a 1-way digest for the user's password using BCrypt-ruby" do
    joe.save
    expect(User.first).to eq(joe)
  end
  it "should not let a user in with a wrong password" do
    joe.save
    expect(joe.authenticate("wrong_pass")).to eq(false)
  end
  it "should not let a user in with a wrong password" do
    joe.save
    expect(joe.authenticate(joe.password)).to eq(joe)
  end

  describe "has_this_video_in_queue" do
    it "returns true if user has video in queue" do
      joe.save
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: joe, video: video)
      expect(joe.has_this_video_in_queue?(video)).to be_true
    end
    it "returns false if user does not have video in queue" do
      joe.save
      video = Fabricate(:video)
      expect(joe.has_this_video_in_queue?(video)).to be_false
    end
  end

  describe "next_position" do
    it "chooses the next number in the position" do
      joe         = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: joe, video: Fabricate(:video))
      expect(joe.next_position).to eq(2)
    end
  end

  describe "renumber_positions" do
    it "should renumber the queue_item positions from 1" do
      joe    = Fabricate(:user)
      monk   = Fabricate(:video)
      castle = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: joe, video: monk, position: 99)
      queue_item2 = Fabricate(:queue_item, user: joe, video: castle, position: 11)
      joe.renumber_positions
      expect(joe.queue_items.map(&:position)).to eq([1,2])
    end
  end

  describe "can_follow?" do
    it "verifies current user is not the passed user" do
      joe = Fabricate(:user)
      expect(joe.can_follow?(joe)).to be_false
    end
    it "verifies passed user is not in current_user's leaders list (followed users)" do
      joe = Fabricate(:user)
      jen = Fabricate(:user)
      joe.following_relationships.create(leader: jen)
      expect(joe.can_follow?(jen)).to be_false
    end
  end

  describe "generate_token" do
    it "generates a random token and loads it into the specified column on user" do
      joe = Fabricate(:user)
      token = User.generate_token
      joe.update_column(:password_reset_token, token)
      expect(User.first.password_reset_token).to eq(token)
    end
  end

  describe "token_expired" do
    it "returns false if the token is outside the allowed timeframe" do
      joe = Fabricate(:user)
      joe.update_columns(prt_created_at: 2.days.ago)
      expect(joe.token_expired?(2)).to be_true
    end
    it "returns true if the token is within the allowed timeframe" do
      joe = Fabricate(:user)
      joe.update_columns(prt_created_at: 2.minutes.ago)
      expect(joe.token_expired?(2)).to be_false
    end
  end

  describe "set_token_data_invalid" do
    it "generates a new password_reset_token for the suer" do
      old_token = User.generate_token
      joe = Fabricate(:user, password_reset_token: old_token,
                             prt_created_at: 2.minutes.ago)
      joe.set_token_data_invalid
      expect(joe.reload.password_reset_token).to_not eq(old_token)
    end
    it "it sets the time to an invalid time one day ago" do
      old_token = User.generate_token
      joe = Fabricate(:user, password_reset_token: old_token,
                             prt_created_at: 2.minutes.ago)
      joe.set_token_data_invalid
      expect(joe.reload.prt_created_at).to be < 1.day.ago
    end
  end

  describe "follow" do
    let(:joe)    { Fabricate(:user) }
    let(:jen)    { Fabricate(:user) }

    it "sets a user to follow the provided other user (leader)" do
      joe.follow(jen)
      expect(joe.leaders.first).to eq(jen)
    end
  end
end
