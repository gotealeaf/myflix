require 'spec_helper'

describe QueueItem do

  it { should belong_to(:creator) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:video) }
  it { should validate_numericality_of(:ranking).only_integer }

  let(:category) { Fabricate(:category) }
  let(:video) { Fabricate(:video, category: category) }
  let(:queue_item) { Fabricate(:queue_item, video: video, creator: Fabricate(:user)) }

  describe "#video_title" do
    it "returns the title of assoicated video" do
      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "category" do
    it "return the assoicated category object" do
      expect(queue_item.category).to eq(category)
    end
  end

  describe "category_name" do
    it "return the name of category name" do
      expect(queue_item.category_name).to eq(category.name)
    end
  end

  describe "rating" do
    it "return the rating of assoicated video" do
      expect(queue_item.rating).to eq(video.rating)
    end
  end

  describe "rating=" do
    context "when the reviews is present" do
      let!(:video) { Fabricate(:video) }
      let!(:current_user) { Fabricate(:user) }
      let!(:review) { Fabricate(:review, creator: current_user, video: video, rating: 2) }
      let!(:queue_item) { Fabricate(:queue_item, creator: current_user, video: video) }
      it "changes the rating" do
        queue_item.rating = 4
        expect(Review.first.rating).to eq(4)
      end

      it "clears the rating" do
        queue_item.rating = nil
        expect(Review.first.rating).to be_nil
      end
    end

    context "when the reviews is not present" do
      let!(:video) { Fabricate(:video) }
      let!(:user) { Fabricate(:user) }
      let!(:queue_item) { Fabricate(:queue_item, creator: user, video: video) }

      it "create a review with rating" do
        queue_item.rating = 4
        expect(Review.first.rating).to eq(4)
      end
    end
  end
end
