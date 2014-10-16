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
  
  describe "POST update_queue" do
    
    context "with valid inputs" do
      it "redirects to the my_queue page" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue items" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(darren.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalizes the position numbers" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(darren.queue_items.map(&:position)).to eq([1, 2])
      end
      it "sets/updates the user rating for the associated video (review)"
    end
    context "with invalid inputs" do
      it "redirects to the my_queue page" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(flash[:error]).to be_present
      end
      it "does not make any modifications to the queue items" do
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
        queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
    context "with unauthenticated users" do
      it "redirects to the sign-in page" do
        post :update_queue, queue_items: [{id: 1, position: 3}, {id: 2, position: 1}]
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with queue items that do not belong to the current user" do
      it "does not make any modifications to the queue items" do
        larissa = Fabricate(:user)
        darren = Fabricate(:user)
        session[:user_id] = darren.id
        queue_item1 = Fabricate(:queue_item, user: larissa, position: 1)
        queue_item2 = Fabricate(:queue_item, user: larissa, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
  
  describe "DELETE destroy" do
    it "redirects to my_queue_path" do
      session[:user_id] = Fabricate(:user).id
      item = Fabricate(:queue_item)
      delete :destroy, id: item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue_item" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      item = Fabricate(:queue_item, user_id: darren.id)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(0)
    end
    it "normalizes the remaining queue items if one is deleted" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      queue_item1 = Fabricate(:queue_item, user: darren, position: 1)
      queue_item2 = Fabricate(:queue_item, user: darren, position: 2)
      queue_item3 = Fabricate(:queue_item, user: darren, position: 3)
      delete :destroy, id: queue_item1.id
      expect(darren.queue_items.map(&:position)).to eq([1,2])
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