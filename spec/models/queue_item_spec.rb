require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer}

  let(:video) { Fabricate(:video) }
  let(:user)  { Fabricate(:user) }
  let(:queue_item) { Fabricate(:queue_item, user: user, video:video) }
  
  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Monk")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Monk")
    end

  end

  describe "#rating" do
    it "returns the user's rating of the associated video" do
      
      
      review = Fabricate(:review, user: user, video: video, rating: 4)
  
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when review is not present" do
      expect(queue_item.rating).to eq(nil)
    end
  end #end #rating

  describe "#rating=" do
    it "changes the rating of the review if it is present" do
      review = Fabricate(:review, video: video, rating: 2, user: user)
      
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
    it "can also clear the rating of a review if present" do
      review = Fabricate(:review, video: video, rating: 2, user: user)
      
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil

    end
    it "will create a review with the rating if the review is not present" do
      
      queue_item.rating = 2
      expect(Review.first.rating).to eq(2)
    end

  end #end #rating=

  describe "#category_name" do
    it "returns the category name for the video associated with queue item" do
      category = Fabricate(:category, name: "Comedy")
      video = Fabricate(:video, category: category)

      queue_item = Fabricate(:queue_item, user: user, video:video)
      expect(queue_item.category_name).to eq("Comedy")
      
    end

  end

  describe "#category" do
    it "returns the category for the video assoc with queue item" do
      category = Fabricate(:category, name: "Comedy")
      video = Fabricate(:video, category: category)

      queue_item = Fabricate(:queue_item, video:video)
      expect(queue_item.category).to eq(category)
    end
  end #end #category
  
  

end  #end QueueItem
