require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:followers).through(:leading_relationships) }
  it { should have_many(:leaders).through(:following_relationships) }
  it { should have_many(:following_relationships).with_foreign_key('follower_id') } 
  it { should have_many(:leading_relationships).with_foreign_key('leader_id') } 
  it { should have_many(:invitations).with_foreign_key('inviter_id') }

  it "generates a token when the user is created" do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

  describe "#change_token" do
    it "generates a new token and saves it to the user" do
      alice = Fabricate(:user)
      prior_token = alice.token
      alice.change_token
      expect(alice.reload.token).not_to eq(prior_token)
    end
  end

  describe "#queued_video?" do
    before do
      Fabricate(:user)
      Fabricate(:video)
    end

    it "returns true if video is in user has queued the video" do
      Fabricate(:queue_item, video_id: Video.first.id, user_id: User.first.id)
      expect(User.first.queued_video?(Video.first)).to be_true
    end

    it "returns false if video has not queued the video" do
      expect(User.first.queued_video?(Video.first)).to be_false
    end
  end

  describe "follow!" do
    it "causes the user to follow the leader" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow!(bob)
      expect(alice.leaders.first).to eq(bob)
    end

    it "causes the leader to gain the user as a follower" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow!(bob)
      expect(bob.followers.first).to eq(alice)
    end
  end

  describe "#follows?" do
    it "returns true if the user is following another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow!(bob)
      expect(alice.follows?(bob)).to be_true
    end

    it "returns false if the user is not following another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      bob.follow!(alice)
      expect(alice.follows?(bob)).to be_false
    end
  end
end