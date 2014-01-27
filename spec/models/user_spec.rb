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
end
