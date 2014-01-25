require 'spec_helper'

describe QueueItem do
  
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer}
  
  describe '#video_title' do
    
    let(:video) { Fabricate(:video, name: 'community' ) }
    let(:queue_item) { Fabricate(:queue_item, video: video) }
    
    it "returns the title of the associated video" do
      expect(queue_item.video_name).to eq('community')
    end
  end
  
  describe "#rating" do
    
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video)  }
    
    it "returns the rating from the review when the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 4)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when the review is not present" do
      expect(queue_item.rating).to eq(nil )
    end
  end
  
  describe "#rating=" do
    
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video)  }
    
    it "changes the rating of the review if review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item.rating = 4
      expect(review.reload.rating).to eq(4)
    end
    
    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item.rating = nil
      expect(review.reload.rating).to be_nil
    end
    it "creates a review with the rating if the review is not present" do
      queue_item.rating = 2
      expect(Review.first.rating).to eq(2)
    end
  end
  
  describe "#category_name" do
    
    let(:category) { Fabricate(:category, name: "comedies") }
    let(:video) { Fabricate(:video, category: category) }
    let(:queue_item) { Fabricate(:queue_item, video: video) }
    
    it "returns the category name for the video" do
      expect(queue_item.category_name).to eq("comedies")
    end
  end
  
  describe "#category" do
    
    let(:category) { Fabricate(:category, name: "comedies") }
    let(:video) { Fabricate(:video, category: category) }
    let(:queue_item) { Fabricate(:queue_item, video: video) }
    
    it "returns the category of the video" do
      expect(queue_item.category).to eq(category)
    end
  end
  
end