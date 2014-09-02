require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "for authenticated users" do 

      it "sets @queue_items" do
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        item1 = Fabricate(:queue_item, user: karen)
        item2 = Fabricate(:queue_item, user: karen)
        get :index
        assigns(:queue_items).should match_array([item1, item2])
      end
    end

    context "for unauthenticated users" do 
      it "should redirect to the signin page" do
        get :index
        response.should redirect_to sign_in_path
      end
    end
  end

  describe "POST create" do
    context "for authenticated users" do
      it "creates a queue item" do
        video = Fabricate(:video)
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        post :create, video_id: video.id
        QueueItem.count.should == 1
      end
      it "associates the queue item to the video" do
        video = Fabricate(:video)
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        post :create, video_id: video.id
        QueueItem.first.video.should == video
      end

      it "associates the queue item with the sign in user" do
        video = Fabricate(:video)
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        post :create, video_id: video.id, user_id: karen.id
        QueueItem.first.user.should == karen
      end
      it "does not add video to queue more than once" do 
        video = Fabricate(:video)
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        Fabricate(:queue_item, video: video, user: karen)
        post :create, video_id: video.id, user_id: karen.id
        karen.queue_items.count.should == 1
      end

      it "adds the last position to queue item" do
        karen = Fabricate(:user)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        video3 = Fabricate(:video)
        session[:user_id] = karen.id
        item1 = Fabricate(:queue_item, video: video1, user: karen)
        item2 = Fabricate(:queue_item, video: video2, user: karen)
        post :create, video_id: video3.id
        queue_item_for_video3 = QueueItem.where(video_id: video3.id, user_id: karen.id).first
        queue_item_for_video3.position.should == 3
      end

      it "redirects to the queue page" do
        video = Fabricate(:video)
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        post :create, video_id: video.id 
        response.should redirect_to my_queue_path
      end

    end

    context "for unauthenticated users" do
      it "does not create a queue item" do
        post :create
        QueueItem.count.should == 0
      end
      it "redirects to the sign in page" do 
        post :create
        response.should redirect_to sign_in_path
      end
    end
  end
end