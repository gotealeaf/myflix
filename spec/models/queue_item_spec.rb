require 'spec_helper'

describe QueueItem do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:video) }

  it "validates uniqueness of position for user" do
    queue_item = Fabricate(:queue_item)
    expect(queue_item).to validate_uniqueness_of(:position).scoped_to(:user_id)
  end

  it "validates uniqueness of video for user" do
    queue_item = Fabricate(:queue_item)
    expect(queue_item).to validate_uniqueness_of(:video).scoped_to(:user_id)
  end

  describe "#video_title" do
    it "returns the titile of the video" do
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq video.title
    end
  end

  describe "#category_name" do
    it "returns the category name of the video" do
      video.category = Category.create(name: "Comedy")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq video.category.name
    end
  end

  describe "#rating" do
    let(:queue_item) { Fabricate(:queue_item, video: video, user: user) }

    it "returns the users rating for the video" do
      review = Fabricate(:review, video: video, user: user)
      expect(queue_item.rating).to eq review.rating
    end

    it "returns nil if not rated by user" do
      expect(queue_item.rating).to eq nil
    end

    it "returns only the users rating for the video if there are many" do
      review = Fabricate(:review, video: video, user: user)
      Fabricate(:review, video: video)
      expect(queue_item.rating).to eq review.rating
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq video.category
    end
  end
end