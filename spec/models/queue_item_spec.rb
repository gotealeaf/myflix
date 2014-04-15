require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:video_id) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id).with_message("is already in queue") }

  describe "#video_title" do
    it "returns the title of the video associated with the queue item" do
      fabricate_queue_item_with_category
      expect(QueueItem.first.video_title).to eq(Video.first.title)
    end
  end

  describe "#rating" do
    before { fabricate_queue_item_with_category }
    
    it "returns the rating associated with the video for the user if it exists" do
      review = Fabricate(:review, user_id: User.first.id, video_id: Video.first.id)
      expect(QueueItem.first.rating).to eq(review.rating)
    end

    it 'returns nil if review does not exist' do
      expect(QueueItem.first.rating).to eq(nil)
    end
  end

  describe "#rating=" do
    before { fabricate_queue_item_with_category }

    it "changes the rating of the review if the review is present" do
      review = Fabricate(:review, creator: User.first, video_id: Video.first.id, rating: 3)
      QueueItem.first.rating = 4
      expect(QueueItem.first.rating).to eq(4)
    end

    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, creator: User.first, video: Video.first, rating: 3)
      QueueItem.first.rating = nil
      expect(QueueItem.first.rating).to be_nil
    end

    it "creates a review with the rating if no review" do
      QueueItem.first.rating = 3
      expect(QueueItem.first.rating).to eq(3)
    end
  end

  describe "#category_name" do
    it "returns the category title of the video associated with the queue item" do
      fabricate_queue_item_with_category
      expect(QueueItem.first.category_name).to eq(Video.first.category.name)
    end
  end

  describe "#category" do
    it "returns the category of the video associated with the queue item" do
      fabricate_queue_item_with_category
      expect(QueueItem.first.category).to eq(Video.first.category)
    end
  end
end