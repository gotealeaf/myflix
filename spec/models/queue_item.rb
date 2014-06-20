require 'rails_helper'

describe QueueItem do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Futurama")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Futurama")
    end
  end

  describe "#rating" do
    it "returns rating if rating exists" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil if rating does not exist" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do
    it "returns category name of the video" do
      category = Fabricate(:category, name: "Documentary")
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category_name).to eq ("Documentary")
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end
