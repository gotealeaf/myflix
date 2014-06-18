require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to teh queue item of the logged in user" do
      lalaine = Fabricate(:user)
      session[:user_id] = lalaine.id
      queue_item1 =  Fabricate(:queue_item, user: lalaine)
      queue_item2 =  Fabricate(:queue_item, user: lalaine)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])

    end
    it "redirects to the sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end 
    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates the queue item that is associated with the signed in user" do
      lalaine = Fabricate(:user)
      session[:user_id] = lalaine.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(lalaine)
    end
    it "puts the video in the last one of the queue" do
      lalaine = Fabricate(:user)
      session[:user_id] = lalaine.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: lalaine)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: lalaine.id).first
      expect(south_park_queue_item.position).to eq(2)
    end
    it "does not add the video if it is already in the queue" do
      lalaine = Fabricate(:user)
      session[:user_id] = lalaine.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: lalaine)
      post :create, video_id: monk.id
      expect(lalaine.queue_items.count).to eq(1)
    end
    it "redirects to the sign in page for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue item" do
      lalaine = Fabricate(:user)
      session[:user_id] = lalaine.id
      queue_item = Fabricate(:queue_item, user: lalaine)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete the queue item if the queue item is not in the current user's queue" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      session[:user_id] = lalaine.id
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects to the sign in page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
    it "renumbers videos left in queue"
    
  end
end