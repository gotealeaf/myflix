require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item1 = Fabricate(:queue_item, user: sam)
      queue_item2 = Fabricate(:queue_item, user: sam)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirect to the sign in page for unauthenticated user" do
      get :index 
      expect(response).to redirect_to sign_in_path
    end
  end


  describe "POST create" do
    it "reirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creawtes a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "create the queue that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "create the queue item that is associated with the sign in user" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(sam)
    end

    it "pusts the video as the last one in queue" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id 
      toy = Fabricate(:video)
      Fabricate(:queue_item, video: toy, user: sam)
      kungfu = Fabricate(:video)
      post :create, video_id: kungfu.id 
      kungfu_queue_item = QueueItem.where(video_id: kungfu.id, user_id: sam.id).first
      expect(kungfu_queue_item.position).to eq(2)
    end

    it "does not add the video  if the video is already in the queue" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id 
      toy = Fabricate(:video)
      Fabricate(:queue_item, video: toy, user: sam)
      post :create, video_id: toy.id 
      expect(sam.queue_items.count).to eq(1)
    end

    it "redirect to the sign in page if unauthenticated user" do
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
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item = Fabricate(:queue_item, user: sam)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete the queue item if the queue item is not in the cuurent user's queue" do
      sam = Fabricate(:user)
      vivian = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item = Fabricate(:queue_item, user: vivian)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects to the sign in page for unauthenticated user" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
end
