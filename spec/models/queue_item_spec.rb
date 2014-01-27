require 'spec_helper'

describe QueueItem do
  let!(:user1) {Fabricate(:user)}
  let!(:category1) {Fabricate(:category, name: "Category1")}
  let!(:video1) {Fabricate(:video, title: "Video1")}
  let!(:review1) {Fabricate(:review, rating: 1, video: video1, user: user1, content: 'Content1')}
  let!(:queue_item1) { Fabricate(:queue_item, user: user1, position: 1, video: video1)}

  it {should belong_to(:user)}
  it {should belong_to(:video)}
  it {should validate_numericality_of(:position).only_integer}

  describe '#video_title' do
    it "returns the title of a video" do
      expect(queue_item1.video_title).to eq('Video1')
    end
  end

  describe '#rating' do
    it "returns the review rating for the movie if any" do
      expect(queue_item1.rating).to eq(1)
    end
    it "returns nil if there is no review"  do
      video3 = Fabricate(:video)
      queue_item3 = Fabricate(:queue_item, video: video3, user: user1 )
    
      expect(QueueItem.last.rating).to be_nil
    end
  end

  describe '#rating=' do
    it "should update an existing rating" do
      queue_item1.rating = 5
     expect(Review.first.rating).to eq(5)
   end
    it "should clear an existing rating"  do
      queue_item1.rating = nil
      expect(Review.first.rating).to  eq(nil)
    end
    it "should create a new rating where a review did not exist" do
      review1 = nil
      queue_item1.rating = 5
      expect(Review.first.rating).to  eq(5)
    end
  end

  describe '#category' do 
    it "should return the category of the video" do      
      video1.category =  category1
      expect(queue_item1.category).to eq(category1)
    end    
  end
  describe '#category_name' do 
    it "should return the category name of the video" do      
      video1.category =  category1
      expect(queue_item1.category.name).to eq('Category1')
    end    
  end
end
