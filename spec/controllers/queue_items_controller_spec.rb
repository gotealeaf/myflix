require 'spec_helper'

describe QueueItemsController do  

  describe "GET index" do
    context "user authenticated" do
      before do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        video2 = Fabricate(:video)
        session[:user_id] = alice.id
      end

      it "sets @queue_items variable, ordered by position" do
        queue_item1 = Fabricate(:queue_item, position: 2, video: Video.first, user: User.first)
        queue_item2 = Fabricate(:queue_item, position: 1, video: Video.find(2), user: User.first)
        get :index
        expect(assigns(:queue_items)).to eq([queue_item2, queue_item1])
      end

      it "renders index template, my_queue page" do
        queue_item1 = Fabricate(:queue_item, position: 1, video: Video.first, user: User.first)
        queue_item2 = Fabricate(:queue_item, position: 2, video: Video.find(2), user: User.first)
        get :index
        expect(response).to render_template :index
      end
    end

    context "user not authenticated" do
      before do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        video2 = Fabricate(:video)
        get :index
      end

      it "does not set @queue_items variable" do
        queue_item1 = Fabricate(:queue_item, position: 1, video: Video.first, user: User.first)
        queue_item2 = Fabricate(:queue_item, position: 2, video: Video.find(2), user: User.first)
        get :index
        expect(assigns(:queue_items)).to eq(nil)
      end
      
      it "redirects to login path" do
        queue_item1 = Fabricate(:queue_item, position: 1, video: Video.first, user: User.first)
        queue_item2 = Fabricate(:queue_item, position: 2, video: Video.find(2), user: User.first)
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "user authenticated" do
      let(:video) { Fabricate(:video) }

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "creates a queue item" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue item that is associated with the user" do
        post :create, video_id: video.id 
        expect(QueueItem.first.user).to eq(User.first)
      end

      it "creates a queue item that is associated with the video" do
        post :create, video_id: video.id 
        expect(QueueItem.first.video).to eq(Video.first)
      end

      it "sets the position of the queue item to the end of the queue" do
        queue_item1 = Fabricate(:queue_item, position: 1, video: video, user: User.first)
        video2 = Fabricate(:video)
        post :create, video_id: video2.id
        second_video_queue_item = QueueItem.where(video_id: video2.id, user_id: User.first.id).first
        expect(second_video_queue_item.position).to eq(2)
      end

      it "redirects to my_queue index page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end

      it "does not add the video to the queue if the video is already in the user's queue" do
        queue_item1 = Fabricate(:queue_item, position: 1, video: video, user: User.first)
        post :create, video_id: video.id
        expect(User.first.queue_items.count).to eq(1)
      end
    end

    context "user not authenticated" do
      before do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        post :create, video_id: video.id
      end

      it "does not add the video to the queue" do
        expect(User.first.queue_items.count).to eq(0)
      end
      
      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    context "user authenticated" do
      before do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        Fabricate(:queue_item, user_id: alice.id, video_id: 1, position: 1)
        Fabricate(:queue_item, user_id: alice.id, video_id: 2, position: 2)
        
      end

      it "deletes the selected item from queue_items if in user's queue" do
        delete :destroy, id: 1
        expect(User.first.queue_items.count).to eq(1)
      end

      it "does not delete the selected item if not in user's queue" do
        bob = Fabricate(:user)
        Fabricate(:queue_item, user: bob, video_id: 1, position: 1)
        delete :destroy, id: 3
        expect(bob.queue_items.count).to eq(1)
      end

      it "does not delete other videos" do
        delete :destroy, id: 1
        expect(User.first.queue_items.first.id).to eq(2)
      end

      it "updates the queue positions of lower ranked items" do
        Fabricate(:queue_item, user_id: User.first.id, video_id: 3, position: 3)
        delete :destroy, id: 1
        expect(User.first.queue_items.first.position).to eq(1)
        expect(User.first.queue_items.last.position).to eq(2)
      end

      it "does not change the queue position of higher ranked items" do
        delete :destroy, id: 2
        expect(User.first.queue_items.count).to eq(1)
        expect(User.first.queue_items.first.position).to eq(1)
      end

      it "redirects to the queue screen" do
        delete :destroy, id: 1
        expect(response).to redirect_to my_queue_path
      end
    end

    context "user not authenticated" do
      before do
        alice = Fabricate(:user)
        Fabricate(:queue_item, user_id: alice.id, video_id: 1)
        Fabricate(:queue_item, user_id: alice.id, video_id: 2)
        delete :destroy, id: 1
      end

      it "does not delete the selected video from user_videos" do
        expect(User.first.queue_items.count).to eq(2)
      end

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end 
    end
  end
end