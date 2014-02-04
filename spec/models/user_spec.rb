require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }

  it "generates a random token when the user is created" do
    sam = Fabricate(:user)
    expect(sam.token).to be_present
  end

  describe "#queued_video?" do
    it "returns trun when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_true
    end

    it "returns false when the user not queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user)
      user.queued_video?(video).should be_false
    end
  end

  describe "#follows?" do
    it "returns true if current user has realitionship with another user" do
      sam = Fabricate(:user)
      vivian = Fabricate(:user)
      Fabricate(:relationship, leader: vivian, follower: sam)
      expect(sam.follows?(vivian)).to be_true
    end

    it "returns false if curren user not following another user" do
      sam = Fabricate(:user)
      vivian = Fabricate(:user)
      expect(sam.follows?(vivian)).to be_false
    end
  end
end
