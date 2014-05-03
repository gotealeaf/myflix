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
    it 'returns the rating of the video if there is a review' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4)
    end
    it 'returns nil if video review is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end #ends rating
  
  describe '#category_names' do
    it 'should display the category name of the category associated with the video if there is one category' do
      category1 = Fabricate(:category, name: 'comedy')
      category2 = Fabricate(:category, name: 'drama')
      video = Fabricate(:video, categories: category1, categories: category2)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_names).to match_array(['comedy', 'drama'])
    end
    
    #it 'should display all the category names of the categories associated with the video if there is more than one category' do
      #category1 = Fabricate(:category, name: 'comedy')
      #category2 = Fabricate(:category, name: 'drama')
      #video = Video.create(title: "monk", description: "funny one", categories: category1, category2)
      #user = Fabricate(:user)
      #queue_item = Fabricate(:queue_item, user: user, video: video)
      #expect(queue_item.category_names).to eq(['comedy', 'drama'])
    #end
  end # ends category_names
end