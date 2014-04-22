require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should have_many(:queue_items).order(:order) }
  it { should have_many(:reviews).order("created_at DESC") }
  
  it "should be validate uniq of email " do
    user = Fabricate :user
    user.save
    expect(user).to validate_uniqueness_of :email
  end
  
  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate :user
      video = Fabricate :video
      Fabricate :queue_item, user: user, video: video

      user.queued_video?(video).should be_true
    end

    it "returns false when the user hasn't queued the video" do
      user = Fabricate :user
      video = Fabricate :video
      
      user.queued_video?(video).should be_false
    end
  end

  describe "#count_queued_videos" do
    it "returns the number of wueued videos by the user" do
      ana = Fabricate :user
      the_wire = Fabricate :video
      the_sopranos = Fabricate :video
      queue_item1 = Fabricate :queue_item, user: ana, video: the_wire
      queue_item2 = Fabricate :queue_item, user: ana, video: the_sopranos

      ana.count_queued_videos.should eq(2)
    end
  end
end