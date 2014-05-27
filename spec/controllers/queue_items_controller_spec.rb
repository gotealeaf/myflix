require 'spec_helper'
describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to sign-in page for unauthenticated user" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end #end GET index

  describe "POST create" do
    it "redirects to the my_queue page" do
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
    it "creates queue item associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
      
    end
    it "creates queue item associated with current user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      
      post :create, video_id: video.id, user_id: alice.id
      expect(QueueItem.first.user).to eq(alice)
      
    end
    it "displays the queue item at the last position on my queue page" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, position: 1, user: alice)
      queue_item2 = Fabricate(:queue_item, position: 2, user: alice)
      south_park = Fabricate(:video)
      
      post :create, video_id: south_park.id, user_id: alice.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user: alice).first
      expect(south_park_queue_item.position).to eq(3)
      
    end
    it "does not add the video to the queue if video is present in the queue" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, video: video,  user: alice)
      post :create, video_id: video.id, user_id: alice.id
      expect(alice.queue_items.count).to eq(1)
    end
    
    it "re directs to sign-in page for unauthenticated user" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path

    
    end

  end #end POST create

  describe "DELETE destroy"  do
    it "redirects back to my queue page" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path

    end
    it "deletes the queue item" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.count).to eq(0)

    end
    it "does not delete a queue item if the queue item is not in the users queue" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      raj = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: raj)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
      
    end
    it "redirects to sign in page for unauthenticated user" do
      delete :destroy, id: 1
      expect(response).to redirect_to sign_in_path
      
    end
    
  end #end POST delete

end
