require 'spec_helper'

describe QueItem do
  it { should belong_to(:video)}
  it { should belong_to(:user)}

  describe "#video_title" do
    it "returns the video title of the que item's associated video" do
      user = Fabricate(:user)
      video = Fabricate(:video, title: "South Park")
      que_item = Fabricate(:que_item, user: user, video: video)

      expect(que_item.video_title).to eq("South Park")
    end
  end
  
  describe "#category_name" do
    it "returns the video's category name of the que item's associated video" do
      user = Fabricate(:user)
      category = Fabricate(:category, name: "drama")
      video = Fabricate(:video, category: category)
      que_item = Fabricate(:que_item, user: user, video: video)

      expect(que_item.category_name).to eq("drama")
    end
  end

  describe "#video_rating" do
    it "returns the user's rating of a video in the que item's associated video's review" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, rating: 4, video: video, user: user)
      que_item = Fabricate(:que_item, user: user, video: video)

      expect(que_item.video_rating).to eq(4)
    end
    it "does not return returns the user's rating of a video in the que item's associated video's review if review is nil" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      que_item = Fabricate(:que_item, user: user, video: video)

      expect(que_item.video_rating).to eq(nil)
    end
  end
end