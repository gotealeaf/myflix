require 'rails_helper.rb'

describe QueueItemsController do
  describe "GET Index" do
    it "sets @queue_items to queue items of logged in user" do
      joe = Fabricate(:user)
      session[:user_id] = joe.id
      queue_item1 = Fabricate(:queue_item, user: joe)
      queue_item2 = Fabricate(:queue_item, user: joe)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST Create" do
    it "redirects to my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates the queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates queue item that is associated with the authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user.id).to eq(session[:user_id])
    end
    it "adds video as last in the queue" do
      joe = Fabricate(:user)
      session[:user_id] = joe.id
      futurama = Fabricate(:video)
      Fabricate(:queue_item, user: joe, video: futurama)
      monk = Fabricate(:video)
      post :create, video_id: monk.id
      monk_queue_item = QueueItem.where(video_id: monk.id, user_id: joe.id).first
      expect(monk_queue_item.position).to eq(2)
    end

    it "does not add video to queue if the video is already in queue" do
      joe = Fabricate(:user)
      session[:user_id] = joe.id
      futurama = Fabricate(:video)
      Fabricate(:queue_item, user: joe, video: futurama)
      post :create, video_id: futurama.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to sign in page for unauthenticated users" do
      post :create, video_id: 1
      expect(response).to redirect_to sign_in_path
    end
  end
end
