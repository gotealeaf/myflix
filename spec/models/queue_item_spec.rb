require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  
  describe '#video_title' do
    it 'should display queue item video title' do
      video = Fabricate(:video, title: 'Futurama')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Futurama')
    end
  end
  
  describe '#rating' do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }
    
    it 'returns the rating of the video if there is a review' do
      review = Fabricate(:review, user: user, video: video, rating: 4)
      expect(queue_item.rating).to eq(4)
    end
    it 'returns nil if video review is not present' do
      expect(queue_item.rating).to eq(nil)
    end
  end #ends rating
  
  describe '#category_names' do
    let(:user) { Fabricate(:user) }
    let(:category1) { Fabricate(:category, name: 'drama') } 
    it 'should display the category name of the category associated with the video if there is one category' do
      video = Fabricate(:video, categories: [category1])
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.category_names).to eq([category1])
    end
    
    it 'should display all the category names of the categories associated with the video if there is more than one category' do
      category2 = Fabricate(:category, name: 'thriller')
      video = Fabricate(:video, categories: [category1, category2])
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.category_names).to match_array([category1, category2])
    end
  end # ends category_names
end