require 'spec_helper'

describe User do
  it { should have_many(              :queue_items ).order("position")}
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

  describe "renumber_positions" do
    it "should renumber the queue_item positions from 1"
  end
end
