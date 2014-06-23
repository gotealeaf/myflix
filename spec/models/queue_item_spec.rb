require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:order).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate :video
      queue_item = Fabricate(:queue_item, video: video)

      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "#rating" do
    it "returns review rating of the video created by the user when the review is present" do
      video = Fabricate :video
      user = Fabricate :user
      queue_item = Fabricate(:queue_item, video: video, user: user)
      review = Fabricate(:review, rating: 3, creator: user, video: video)

      expect(queue_item.rating).to eq(3)
    end

    it "returns blank when the video has no review writen by the user" do
      video = Fabricate :video
      user = Fabricate :user
      queue_item = Fabricate(:queue_item, video: video, user: user)

      expect(queue_item.rating).to be_nil
    end
  end

  describe "#category_name" do
    it "returns the video's category" do
      cat = Fabricate(:category, name: "Brasismo")
      video = Fabricate(:video, category: cat)
      queue_item = Fabricate(:queue_item, video: video)

      expect(queue_item.category_name).to eq("Brasismo")      
    end
  end

  describe "#category" do 
    it "returns teh categpry of the video" do
      cat = Fabricate(:category, name: "Brasismo")
      video = Fabricate(:video, category: cat)
      queue_item = Fabricate(:queue_item, video: video)

      expect(queue_item.category).to eq(cat)    
    end 
  end
end