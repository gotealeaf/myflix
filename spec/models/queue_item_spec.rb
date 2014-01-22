require 'spec_helper'

describe QueueItem do
  set_user1
  set_video1
  set_review1
  set_queue_item1
  set_category1
  
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
      # review1 = Fabricate(:review, rating: 1, video: video1, user: user1)
      review1.rating = 5
      expect(queue_item1.rating).to eq(5)
    end

    it "returns nil if there is no rating"  do
      expect(queue_item1.rating).to be_nil
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
