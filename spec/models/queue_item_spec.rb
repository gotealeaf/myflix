require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe "#video_title" do
    it "returns the title of the associated video" do
    	video = Fabricate(:video, title: 'Inception')
    	queue_item = Fabricate(:queue_item, video: video)
    	expect(queue_item.video_title).to eq('Inception')
    end
  end

  describe "#rating" do
  	it "returns the rating from the review when there is a review" do
  	  video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when there is no review" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end

  end  

  describe "#category_name" do
    it "returns the name of the video's category" do
      category = Fabricate(:category, name: "science_fiction")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("science_fiction")
    end
  end

  describe "#category" do
    it "returns the video's category" do
      category = Fabricate(:category, name: "science_fiction")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end