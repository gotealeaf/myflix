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

    it "displays the video rating given by the user, if any"

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

    it " normalizes the position number after deleting a queue item" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        delete :destroy, id: queue_item1.id
      
        expect(queue_item2.reload.position).to eq(1)
      end
    
  end #end POST delete

  describe "POST update_queue" do
    context "with valid inputs" do
      let(:video) {Fabricate(:video)}
      let (:queue_item1) {Fabricate(:queue_item, user: alice, position: 1, video: video)}
      let (:queue_item2) {Fabricate(:queue_item, user: alice, position: 2, video: video)}
      let (:alice){Fabricate(:user)}
      before do
        session[:user_id] = alice.id
      end

      it "redirects to my_queue page" do
        
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2,queue_item1])
      end
      it " normalizes the position number" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1, 2])
      end

    end #end context with valid inputs
    context "with invalid inputs" do
      let(:video) {Fabricate(:video)}
      let (:queue_item1) {Fabricate(:queue_item, user: alice, position: 1, video: video)}
      let (:queue_item2) {Fabricate(:queue_item, user: alice, position: 2, video: video)}
      let (:alice){Fabricate(:user)}
      before do
        session[:user_id] = alice.id
      end
      
      it "redirects to my queue page" do

        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets flash error message" do

        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.2}, {id: queue_item2.id, position: 1}]
        expect(flash[:error]).to be_present
      end
      it "does not change the queue items" do

        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end #end context "with invalid inputs"
    context "with unauthenticated user" do
      it "redirects to sign in page" do
        
        post :update_queue, queue_items: [{id: 2, position: 3}, {id: 1, position: 1}]
        expect(response).to redirect_to sign_in_path
      end
    end #end context unauthenticated user
    context "with queue items that do not belong to the current user" do  #update can be made via the html page (inspect element)
      it "should not update the queue" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        raj = Fabricate(:user)
        video = Fabricate(:video)
        
        queue_item1 = Fabricate(:queue_item, user: raj, position: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)

        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(queue_item1.reload.position).to eq(1)
      
      end

    end #end context with queue items not belonging to current user



  end #end describe POST update_queue

end #end QueueItems Controller
