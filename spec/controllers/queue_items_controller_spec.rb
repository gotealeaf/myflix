require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated users" do
      it "sets the @queue_items to the queue items of current user" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        queue_item1 = Fabricate(:queue_item, user: desmond)
        queue_item2 = Fabricate(:queue_item, user: desmond)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
      it "should render the index template" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        queue_item1 = Fabricate(:queue_item, user: desmond)
        queue_item2 = Fabricate(:queue_item, user: desmond)
        get :index
        expect(response).to render_template :index
      end
    end

    context "with unuthenticated users" do
      it "should redirect to login path" do
        desmond = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: desmond)
        queue_item2 = Fabricate(:queue_item, user: desmond)
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      it "should redirect to my_queue page" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "should create a queue item" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "should create a queue item associate with video" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "should create a queue item associate with current user" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(desmond)
      end
      it "puts item as the last one of the queue" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        video1 = Fabricate(:video)
        QueueItem.create(user: desmond, video: video1)
        video2 = Fabricate(:video)
        post :create, video_id: video2.id
        queue_item = QueueItem.where(user: desmond, video: video2).first
        expect(queue_item.position).to eq(2)
      end
      it "deoes not add video in the queue if it is already in" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        video1 = Fabricate(:video)
        QueueItem.create(user: desmond, video: video1)
        post :create, video_id: video1.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "with unuthenticated users" do
      it "should redirect to login path" do
        post :create, video_id: 3
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      it "should redirect to my queue page" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        queue_item = Fabricate(:queue_item, user: desmond)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
      it "should delete the queue item" do
        desmond = Fabricate(:user)
        session[:user_id] = desmond.id
        queue_item = Fabricate(:queue_item, user: desmond)
        delete :destroy, id: queue_item.id
        expect(desmond.queue_items.count).to eq(0)
      end
      it "should not delete the queue item if it is not own by current user" do
        desmond = Fabricate(:user)
        alice = Fabricate(:user)
        session[:user_id] = desmond.id
        queue_item = Fabricate(:queue_item, user: alice)
        delete :destroy, id: queue_item.id
        expect(alice.queue_items.count).to eq(1)
      end
    end

    context "with unuthenticated users" do
      it "should redirect to login path" do
        delete :destroy, id: 3
        expect(response).to redirect_to login_path
      end
    end
  end
end
