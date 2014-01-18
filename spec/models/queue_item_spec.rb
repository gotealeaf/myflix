require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe '#rating' do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    before do
      #session[:user_id] = user.id
      #looks like I dont need to set session[:user_id] here as I'm not testing authentication here, but, say if I do, why I'm getting a undefined local variable or method `session' error here? this works at my reviews_controller_spec.rb#9
    end
    it 'returns user rating if exists' do
      review = Fabricate(:review, rating: 3, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user) 
      expect(queue_item.rating).to eq(3)
    end
    it 'returns nil if user has not yet rated the video' do
      queue_item = Fabricate(:queue_item, video: video, user: user) 
      expect(queue_item.rating).to eq(nil)
    end
  end
end
