require 'spec_helper'

describe QueueItemsController do
  describe 'POST create' do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    before do
      session[:user_id] = user.id
      post :create, video_id: video.id
    end
    it 'redirects user to my queue page' do
      expect(response).to redirect_to my_queue_path
    end
    it 'creates a queue item' do
      expect(QueueItem.count).to eq(1)
    end
    it 'creates a queue item that is associated with the video' do
      expect(QueueItem.first.video).to eq(video)
    end
    it 'creates a queue item that is associated with the user' do
      expect(QueueItem.first.user).to eq(user)
    end
  end
  
  describe 'POST create' do
    it 'puts the queue item to the last place in the queue' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user)
      queue_item2 = Fabricate(:queue_item, user: user)
      post :create, video_id: video.id
      expect(QueueItem.last.position).to eq(3)
    end
    it 'does not create a queue item if video already exist in the queue' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
  end
end
