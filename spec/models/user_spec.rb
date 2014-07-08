require 'rails_helper'

describe User do
  it { should validate_presence_of (:name) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  it { should validate_uniqueness_of (:email) }
  it { should have_secure_password }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:invitations) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end

  describe "#queued_video?" do
    it "returns true when the video is already in the user's queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to eq(true)
    end

    it "returns false when the video is not in the user's queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to eq(false)
    end
  end

  describe "User #follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to eq(true)
    end

    it "returns false if the user does not have a following relaitonship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      expect(alice.follows?(bob)).to eq(false)
    end
  end

  describe "User #follow" do
    it "follows another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be true
    end

    it "does not follow oneself" do
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to be false
    end
  end
end