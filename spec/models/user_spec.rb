require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:email)}
  it {should have_many(:queue_items).order("position")}
  it {should have_many(:reviews).order("created_at DESC")}

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      lalaine =  Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: lalaine, video: video)
      lalaine.queued_video?(video).should be_true
    end
    it "returns false when the user hasn't queued the video" do
      lalaine =  Fabricate(:user)
      video = Fabricate(:video)
      lalaine.queued_video?(video).should be_false
    end
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: lalaine)
      expect(bob.follows?(lalaine)).to be_true
    end
    it "returns false if the user does not have a following relationship with that other user" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: lalaine, leader: bob)
      expect(bob.follows?(lalaine)).to be_false
    end
  end
end