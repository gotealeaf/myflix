require 'spec_helper'

describe QueueItem do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Monk")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Monk")
    end
  end

  describe "#rating" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

    it "returns the rating from the review when the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 4)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the review is not present" do
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do
    it "returns the video's category name" do
      category = Fabricate(:category, name: "Horror")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Horror")
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category, name: "Horror")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end

  describe "#rating=" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video, rating: 2) }

    it "changes the rating of the review if the review is present" do
      review = Fabricate(:review, user: user, video: video)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end

    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, user: user, video: video)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a review with the rating if the review is not present" do
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
    end
  end
end
