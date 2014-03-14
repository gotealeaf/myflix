require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe "#video_title" do
    it "should return the title of associated video" do
      video = Fabricate(:video, title: 'video1')
      queue_item =  Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("video1")
    end
  end

  describe "#rating" do
    it "should return rating from review when the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(5)
    end
    it "should return nil when the review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to be_nil
    end
  end

  describe "#category_name" do
    it "should return category name of the video" do
      category = Fabricate(:category, name: 'cate1')
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category_name).to eq('cate1')
    end
  end

  describe "#category" do
    it "should return category of the video" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end
