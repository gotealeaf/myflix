require 'spec_helper'

describe QueueItem do
  it { should belong_to(:video)}
  it { should belong_to(:user)}

  describe "#video_title" do
    it "returns the video title of the que item's associated video" do
      user = Fabricate(:user)
      video = Fabricate(:video, title: "South Park")
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(queue_item.video_title).to eq("South Park")
    end
  end
  
  describe "#category_name" do
    it "returns the video's category name of the que item's associated video" do
      user = Fabricate(:user)
      category = Fabricate(:category, name: "drama")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(queue_item.category_name).to eq("drama")
    end
  end

  describe "#review_rating" do
    it "returns the user's rating of a video in the que item's associated video's review" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, rating: 5.0, video: video, user: user)
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(queue_item.review_rating).to eq(5.0)
    end
    it "does not return returns the user's rating of a video in the que item's associated video's review if review is nil" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(queue_item.review_rating).to eq(nil)
    end
  end

  describe "#review_rating=" do
    it "changes the rating of the review if the review is present" do
      bob = Fabricate(:user)
      south_park = Fabricate(:video)
      review = Fabricate(:review, user: bob, video: south_park, rating: 2)
      queue_item = Fabricate(:queue_item, user: bob, video: south_park)
      queue_item.review_rating = 4

      expect(Review.first.rating).to eq(4)
    end

    it "clears the rating of the review if the user sets the review an empty value and the review is present" do
      bob = Fabricate(:user)
      south_park = Fabricate(:video)
      review = Fabricate(:review, user: bob, video: south_park, rating: 2)
      queue_item = Fabricate(:queue_item, user: bob, video: south_park)
      queue_item.review_rating = nil

      expect(Review.first.rating).to be_nil
    end
    it "creates a review with the rating if the review is not present" do
      bob = Fabricate(:user)
      south_park = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: bob, video: south_park)
      queue_item.review_rating = 4

      expect(Review.first.rating).to eq(4)
    end
    
  end
end