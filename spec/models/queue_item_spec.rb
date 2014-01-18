require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'nimei')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('nimei')
    end
  end

  describe "#rating" do
    it "returns the rating from the review when the review is presence" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rate: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when the review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do
    it "returns the category name of the video" do
      category = Fabricate(:category, name: "action")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("action")
    end
  end

  describe "#category" do
    it "returns the category of the video" do

    end
  end
end

