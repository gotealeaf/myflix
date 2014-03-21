require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:video_id) }
  it { should validate_uniqueness_of(:position) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id).with_message("is already in queue") }

  describe "#video_title" do
    it "returns the title of the video associated with the queue item" do
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "#rating" do
    it "returns the rating associated with the video for the user if it exists" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user_id: user.id, video: video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(review.rating)
    end

    it "returns nil if review does not exist" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq("Unrated")
    end
  end

  describe "#category_name" do
    it "returns the category title of the video associated with the queue item" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq(video.category.name)
    end
  end

  describe "#category" do
    it "returns the category of the video associated with the queue item" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(video.category)
    end
  end
end