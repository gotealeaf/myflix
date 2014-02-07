require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      amanda = Fabricate(:user)
      session[:user_id] = amanda.id
      queue_item1 = Fabricate(:queue_item, user: amanda)
      queue_item2 = Fabricate(:queue_item, user: amanda)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end


    it "redirects to sign-in for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "redirects to my queue" do
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

    it "creates a queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item that is associated with the signed-in user" do
      amanda = Fabricate(:user)
      session[:user_id] = amanda.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(amanda)
    end

    it "puts the video as the last one in the queue" do
      amanda = Fabricate(:user)
      session[:user_id] = amanda.id
      inc = Fabricate(:video)
      Fabricate(:queue_item, video: inc, user: amanda)
      lost = Fabricate(:video)
      post :create, video_id: lost.id
      lost_queue_item = QueueItem.where(video_id: lost.id, user_id: amanda.id).first
      expect(lost_queue_item.position).to eq(2)
    end

    it "does not add the video if it is already in the queue" do
      amanda = Fabricate(:user)
      session[:user_id] = amanda.id
      inc = Fabricate(:video)
      Fabricate(:queue_item, video: inc, user: amanda)
      post :create, video_id: inc.id
      expect(amanda.queue_items.count).to eq(1)
    end

    it "redirects to sign_in page for unauthenticated users" do
      post :create, video_id: 2
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    it "removes the selected queue item from the queue" do
      amanda = Fabricate(:user)
      session[:user_id] = amanda.id
      queue_item = Fabricate(:queue_item, user: amanda)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "redirects to my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      amanda = Fabricate(:user)
      bob = Fabricate(:user)
      session[:user_id] = amanda.id
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to sign in for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
end