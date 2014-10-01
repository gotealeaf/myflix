require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order('position asc') }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end

  it "generates a random token when the user is created" do
    karen = Fabricate(:user)
    karen.token.should be_present
  end
  
  describe "#queued_video?" do 
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_true
    end
    it "returns false when the user has not queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      user.queued_video?(video).should be_false
    end
  end

  describe "#video_queue_count" do
    it "returns the number of videos in the users queueu" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      user.video_queue_count.should == 1
    end
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      karen = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: karen)
      karen.follows?(bob).should be_true
    end
    it "returns false if the user does not have a following relationship with another user" do
      karen = Fabricate(:user)
      bob = Fabricate(:user)
      karen.follows?(bob).should be_false
    end
  end

  describe "#follow" do
    it "follows another user" do
      karen = Fabricate(:user)
      bob = Fabricate(:user)
      karen.follow(bob)
      karen.follows?(bob).should be_true
    end
    it "does not follow one self" do
      karen = Fabricate(:user)
      karen.follow(karen)
      karen.follows?(karen).should be_false
    end
  end
end