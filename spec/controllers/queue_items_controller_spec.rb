require "spec_helper"

describe QueueItemsController do
  context "authenticated user" do  
    describe "GET index" do
      it "sets @my_queue variable" do 
        user = Fabricate :user
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        queue_item3 = Fabricate(:queue_item, user: user)

        get :index

        expect(assigns :queue_items).to match_array([queue_item1, queue_item2, queue_item3])
      end
    end

    describe "POST create" do
    
      let(:user){ Fabricate :user }    
      let(:video){ Fabricate :video }     

      before do
        session[:user_id] = user.id
      end

      it "redirects to my_queue_path" do
        post :create, video_id: video.id  
        expect(response).to redirect_to my_queue_path
      end

      it "creates a queue_item" do   
        post :create, video_id: video.id  
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue_item associated with the current video" do
        post :create, video_id: video.id  
        expect(QueueItem.first.video).to eq(video)
      end

      it "creates a queue_item associated with the current user" do
        post :create, video_id: video.id  
        expect(QueueItem.first.user).to eq(user)
      end

      it "sets the video the last one in the user's queue" do
        Fabricate(:queue_item, user: user, video: video, order: 2)
        video1 = Fabricate :video
        post :create, video_id: video1.id  
        video1_queue_item = QueueItem.where(user: user, video: video1).first                  
        expect(video1_queue_item.order).to eq(2)          
      end

      it "does not add the video to the queue if the video is already in it" do
        Fabricate(:queue_item, user: user, video: video, order: 2)
        post :create, video_id: video.id  
        expect(QueueItem.count).to eq(1)  
      end
    end

    describe "DELETE destroy" do

      let(:user){ Fabricate :user }    
      let(:video){ Fabricate :video }     

      before do
        session[:user_id] = user.id
      end

      it "redirects to my_queue page" do
        queue_item = Fabricate :queue_item
        delete :destroy, id: queue_item.id

        expect(response).to redirect_to my_queue_path
      end

      it "removes the selected queue_item" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(0)  
      end

      it "does not delete the queue_item if the queue_item is not in the user's queue" do
        user1 = Fabricate :user
        queue_item = Fabricate(:queue_item, user: user1)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(1)
      end
    end
  end

  context "unauthenticated user" do 
    describe "GET index" do
      it "redirects to sign_in page" do 
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "POST create" do
      it "redirects to sign_in_path" do
        video = Fabricate :video
        post :create, video_id: video.id  
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign_in_path" do
        delete :destroy, id: 3
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end