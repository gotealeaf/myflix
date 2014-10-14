require 'spec_helper'

describe QueueItem do
  
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  
  describe "#video_title" do
    it "returns the title for the associated video" do
      video = Fabricate(:video, title: "Funny Stuff")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Funny Stuff")
    end
  end
  
  describe "#rating" do
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, reviewer: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when there is no review present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end
  
  describe "#category_name" do
    it "returns the category name for the associated video" do
      category = Fabricate(:category, name: "Crazy")
      video = Fabricate(:video)
      video.categories << category
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Crazy")
    end
  end
  
  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category, name: "Crazy")
      video = Fabricate(:video)
      video.categories << category
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(video.categories.first)
    end
  end
  
end