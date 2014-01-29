require 'spec_helper'

describe User do

  it {should have_many(:queue_items).order(:position)}

  describe '#queued_video_previsouly?' do
    let!(:user1) {Fabricate(:user)}
    let!(:video1) {Fabricate(:video, title: "Video1")}
    let!(:queue_item1) { Fabricate(:queue_item, user: user1, position: 1, video: video1)}

    it "should return true if the video is in the queue" do
    # expect(current_user.queue_items.map(&:video).include?(video1)).to eq(true)
    expect(user1.has_queued_video?(video1)).to be_true
    end
  end 

  describe 'reviews' do
    it "should return an array of reviews for the user" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, user: user)
      review2 = Fabricate(:review, video: video, user: user)
      expect(user.reviews).to match_array([review1,review2])
    end
  end

  describe "#follows?" do
    it "should return true if the person is already being followed" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be_true
    end
    it "should return false if the person is not being followed" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: charlie)
      expect(alice.follows?(bob)).to be_false
    end

  end

end
