require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_items1 = Fabricate(:queue_item, user: user)
      queue_items2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_items1, queue_items2])
    end
    it "redirect to the sign in page for unauthenticated user" do
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
    it "creates the queue item that is assosiated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates the queue item that is assosiated with the sign in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.user).to eq(user)
    end
    it "puts the video as the last one in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      video1 = Fabricate(:video)
      post :create, video_id: video1.id
      queue_item_for_video1 = QueueItem.where(video_id: video1.id, user_id: user.id).first
      expect(queue_item_for_video1.position).to eq(2)
    end
    it "does not add the video the queue if the video is already in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      post :create, video_id: video.id
      expect(user.queue_items.count).to eq(1)
    end
    it "redirects to the sign in page for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    it "redirect to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "delete the queue item" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, user: user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "normalizes the remaining queue items" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user, position: 1)
      queue_item2 = Fabricate(:queue_item, user: user, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end
    it "does not delete the queue item if the queue item is not in the current user's queue" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      session[:user_id] = user1.id
      queue_item = Fabricate(:queue_item, user: user2)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirect to sign in page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      let (:user)  { Fabricate(:user) }
      let (:video) { Fabricate(:video) }
      let (:queue_item1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let (:queue_item2) { Fabricate(:queue_item, user: user, video: video, position: 2) }
      
      before do
        session[:user_id] = user.id
      end

      it "redirect to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item1.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalizes the position nambers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 2}]
        expect(user.queue_items.map(&:position)).to eq([1,2])
      end
    end

    context "with invalid inputs" do
      let (:user)  { Fabricate(:user) }
      let (:video) { Fabricate(:video) }
      let (:queue_item1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let (:queue_item2) { Fabricate(:queue_item, user: user, video: video, position: 2) }
      
      before do
        session[:user_id] = user.id
      end
      
      it "redurect to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4.3}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4.3}, {id: queue_item2.id, position: 2}]
        expect(flash[:danger]).to be_present
      end
      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirect to the sign in page" do
        post :update_queue, queue_items: [{id: 2, position: 4}, {id: 1, position: 2}]
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        video = Fabricate(:video)
        user1 = Fabricate(:user)
        session[:user_id] = user1.id
        user2 = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: user1, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user2, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item2.id, position: 4}, {id: queue_item1.id, position: 2}]
        expect(queue_item2.reload.position).to eq(2)
      end
    end
  end
end