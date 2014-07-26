require 'spec_helper'

describe QueueItem do

  it { should belong_to(:creator) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:ranking).only_integer }

  let(:category) { Fabricate(:category) }
  let(:video) { Fabricate(:video, category: category) }
  let(:queue_item) { Fabricate(:queue_item, video: video) }

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

end
