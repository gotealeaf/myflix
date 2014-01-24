require 'spec_helper'

describe QueueItemsController do
  before { session[:user_id] = Fabricate(:user).id }
  let(:my_video) { Fabricate(:video) }
  let(:current_user) { User.find(session[:user_id]) }
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to the sign in page for unauthenticated users" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  describe "POST create" do
    it "should create an item in the queue" do
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 1
    end
    it "should not add an item to the queue if there's one already there" do
      my_video.queue_items.create(user: current_user, ranking: current_user.queue_items.count + 1)
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 1
    end
    it "should be the last item in the queue" do
      other_video = Fabricate(:video)
      other_video.queue_items.create(user: current_user, ranking: current_user.queue_items.count + 1)
      post :create, video_id: my_video.id
      expect(current_user.queue_items.last.video).to eq my_video
    end
    it "should not add an item to the queue if not logged in" do
      session[:user_id] = nil
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 0
    end
    it "should redirect to the queue items page" do
      post :create, video_id: my_video.id
      expect(response).to redirect_to queue_items_path
    end
    it "creates the queue item that is associated with the video" do
      post :create, video_id: my_video.id
      expect(QueueItem.first.video).to eq(my_video)
    end
    it "creates the queue item that is associated with the signed in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      post :create, video_id: my_video.id
      expect(my_video.queue_items.first.user).to eq(alice)
    end
    it "redirects to the sign in page for unauthenticated users" do
      session[:user_id] = nil
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      queue_item = Fabricate(:queue_item)
      delete :destroy, video_id: my_video.id, id: queue_item.id
      expect(response).to redirect_to queue_items_path
    end
    it "deletes the queue item" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item = Fabricate(:queue_item, user: alice)
      delete :destroy, video_id: my_video.id, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete the queue item if the queue item is not in the current user's queue" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, video_id: my_video.id, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects to the sign in page for unauthenticated users" do
      session[:user_id] = nil
      delete :destroy, video_id: my_video.id, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
end