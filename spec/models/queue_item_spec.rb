require 'spec_helper'

describe QueueItem do
  
  it {should belong_to(:user)}
  it {should belong_to(:video)}
  it {should validate_numericality_of(:position).only_integer}

  describe '#video_title' do
    it "returns the title of a video" do
      video = Fabricate(:video, title:  "Seraph")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Seraph')
    end
  end

  describe '#rating' do
    it "returns the review rating for the movie if anny" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, rating: 4, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil if there is no rating"  do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to be_nil

    end
  end


    describe '#category' do 
      it "should return the category of the video" do      
        category = Fabricate(:category)
        video = Fabricate(:video, category: category)
        queue_item = Fabricate(:queue_item, video: video)
        expect(queue_item.category).to eq(category)
      end    
  
    end
    describe '#category_name' do 
      it "should return the category name of the video" do      
        category = Fabricate(:category, name: 'Comedy')
        video = Fabricate(:video, category: category)
        queue_item = Fabricate(:queue_item, video: video)
        expect(queue_item.category.name).to eq('Comedy')
      end    
    end

end
