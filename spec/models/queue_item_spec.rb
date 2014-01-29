require 'spec_helper'

describe QueueItem do
  it { should validate_presence_of(:ranking) }
  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_numericality_of(:ranking).only_integer }

  describe "rating handling" do
    it "should return review rating if present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, rating: 4, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.rating).to eq review.rating
    end
    it "should return 0 if no review rating" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.rating).to eq 0
    end
  end
  describe "#category" do
    it "should return the video category" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.category).to eq video.category
    end
  end
  describe "#video_title" do
    it "should return the video title" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.video_title).to eq video.title
    end
  end
  describe "#video_title" do
    it "should return the category name" do
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
      expect(queue_item.category_name).to eq video.category.name
    end
  end
  describe "#rating=" do
    context "review exists" do
      it "should update the review's rating" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, rating: 4, video: video, user: user)
        queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
        queue_item.rating = 1
        expect(queue_item.rating).to eq(1)
      end
      it "should remove the review's rating if no rating desired" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, rating: 4, video: video, user: user)
        queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
        queue_item.rating = 0
        expect(review.reload.rating).to be_nil
      end
    end
    context "review does not exist" do
      it "should create a review with the correct rating" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, video: video, user: user, ranking: 1)
        queue_item.rating = 5
        expect(Review.first.rating).to eq(5)
      end
    end
  end
end