require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      queue_item1 = Fabricate(:queue_item, user: darren)
      queue_item2 = Fabricate(:queue_item, user: darren)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to the sign-in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "POST create" do
    it "redirects to the my_queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a new queue_item object" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "associates the queue_item with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "associates the queue_item with the signed-in user" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(darren)
    end
    it "puts the video as the last one in the que" do 
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      video1 = Fabricate(:video)
      Fabricate(:queue_item, video: video1, user: darren)
      video2 = Fabricate(:video)
      post :create, video_id: video2.id
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: darren.id).first
      expect(video2_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if it is already there" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      video1 = Fabricate(:video)
      Fabricate(:queue_item, video: video1, user: darren)
      post :create, video_id: video1.id
      expect(darren.queue_items.count).to eq(1)
    end
    it "redirects to the sign_in page for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the queue_item" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      item = Fabricate(:queue_item, user_id: darren.id)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(0)
    end
    it "redirects to my_queue_path" do
      session[:user_id] = Fabricate(:user).id
      item = Fabricate(:queue_item)
      delete :destroy, id: item.id
      expect(response).to redirect_to my_queue_path
    end
    it "does not delete the queue item if it is not in the current_user's queue" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      larissa = Fabricate(:user)
      item = Fabricate(:queue_item, user_id: larissa.id)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects to the sign_in page for unauthenticated users" do
      delete :destroy, id: 2
      expect(response).to redirect_to sign_in_path
    end
  end
  
end