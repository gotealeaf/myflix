  require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
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

    it "creates a queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    
    it "creates a queue item that is associated with signed in user" do
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(mark)
    end
    
    it "puts the video as the last one in the queue" do
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: mark)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: mark.id).first
      expect(south_park_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if the video 
    is already in the queue" do
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: mark)
      post :create, video_id: monk.id
      expect(mark.queue_items.count).to eq(1)
  end
    it "redirects to the sign page for unauthenticated 
    users" do
     post :create, video_id: 3
     expect(response).to redirect_to  sign_in_path
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
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      queue_item = Fabricate(:queue_item, user: mark)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      queue_item1 = Fabricate(:queue_item, user: mark, position: 1)
      queue_item2 = Fabricate(:queue_item, user: mark, position: 2)

      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)

    end
    
    it "does not delete the queue item if queue item is
    not in current user's queue" do
      mark = Fabricate(:user)
      ted = Fabricate(:user)
      session[:user_id] = mark.id
      queue_item = Fabricate(:queue_item, user: ted)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    
    it "redirects to sign in page for unauthenticated user" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end 
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      let(:mark) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: mark, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: mark, position: 2, video: video) }
      
      before do
        session[:user_id] = mark.id
      end

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
          {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      
      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
          {id: queue_item2.id, position: 1}]
        expect(mark.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
          {id: queue_item2.id, position: 2}]
        expect(queue_item1.reload.position).to eq(2)
        expect(queue_item2.reload.position).to eq(1)
      end
    end
   
    context "with invalid inputs" do
      let(:mark) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: mark, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: mark, position: 2, video: video) }
      
      before do
        session[:user_id] = mark.id
      end
      

      it "redirects to the my queue page" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, 
          {id: queue_item2.id, position: 2}]
          expect(response).to redirect_to my_queue_path 
      end
      
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, 
          {id: queue_item2.id, position: 2}]
        expect(flash[:error]).to be_present 
      end
      
      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
          {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1) 
      end
    end


    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        post :update_queue, queue_items: [{id: 2, position: 3}, 
        {id: 5, position: 2}] 
        expect(response).to redirect_to sign_in_path
      end       
    end

    context "with queue items that do not belong to current user" do
      it "does not change the queue items" do
      mark = Fabricate(:user)
      session[:user_id] = mark.id
      video = Fabricate(:video)
      ted = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: ted, position: 1, video: video)
        
      queue_item2 = Fabricate(:queue_item, user: mark, position: 2, video: video)
        
      post :update_queue, queue_items: [{id: queue_item1.id, position: 1}, 
          {id: queue_item2.id, position: 2}]
      expect(queue_item1.reload.position).to eq(1)

      end
    end
  end
end

  

  