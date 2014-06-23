require "rails_helper"

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the current user" do
      dan = Fabricate(:user)
      session[:user_id] = dan.id
      queue_item1 = Fabricate(:queue_item, user: dan)
      queue_item2 = Fabricate(:queue_item, user: dan)

      get :index

      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to the root path for unathenticated users" do
      get :index

      expect(response).to redirect_to root_path
    end
  end #GET index

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

    it "creates a queue item associated with the current video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)

      post :create, video_id: video.id

      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item assocaited with the current user" do
      condor = Fabricate(:user)
      session[:user_id] = condor.id
      video = Fabricate(:video)

      post :create, video_id: video.id

      expect(QueueItem.first.user).to eq(condor)
    end

    it "adds the video at the end of the queue" do
      condor = Fabricate(:user)
      session[:user_id] = condor.id
      existing_video = Fabricate(:video)
      Fabricate(:queue_item, user: condor, video: existing_video)
      newly_added_video = Fabricate(:video)

      post :create, video_id: newly_added_video.id
      new_queue_item = QueueItem.where(video_id: newly_added_video.id, user_id: condor.id).first

      expect(new_queue_item.position).to eq(2)
    end

    it "does not add the video to the queue if that video is already present" do
      condor = Fabricate(:user)
      session[:user_id] = condor.id
      existing_video = Fabricate(:video)
      Fabricate(:queue_item, user: condor, video: existing_video)

      post :create, video_id: existing_video.id
      new_queue_item = QueueItem.where(video_id: existing_video.id, user_id: condor.id).first

      expect(condor.queue_items.count).to eq(1)
    end

    it "redirects to the root path for unathenticated users" do
      post :create, video_id: 3

      expect(response).to redirect_to root_path
    end
  end #POST create

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      
      delete :destroy, id: queue_item.id

      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      taren = Fabricate(:user)
      session[:user_id] = taren.id
      queue_item = Fabricate(:queue_item, user: taren)
      
      delete :destroy, id: queue_item.id

      expect(QueueItem.count).to eq(0)
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      taren = Fabricate(:user)
      cullen = Fabricate(:user)
      session[:user_id] = taren.id
      queue_item = Fabricate(:queue_item, user: cullen)

      delete :destroy, id: queue_item.id

      expect(QueueItem.count).to eq(1)
    end

    it "redirects to the root path for an unathenticated user" do
      delete :destroy, id: 3

      expect(response).to redirect_to root_path
    end
  end #DELETE destroy
end