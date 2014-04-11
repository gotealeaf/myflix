require 'spec_helper'

describe QueuesController do

  let(:user)  { Fabricate(:user) }
  let(:video) { Fabricate(:video) }
  let!(:queue_target) { QueueItem.where(user: user).count + 1 }

  describe "queues#create" do
    context "logged in" do
      before(:each) do
        session[:user_id] = user.id
        post :create, user_id: user.id, video_id: video.id
      end
      it "sets user relationship" do
        expect(assigns(:queue_item).user).to eq user
      end
      it "sets video relationship" do
        expect(assigns(:queue_item).video).to eq video
      end
      it "sets position as last item" do
        expect(assigns(:queue_item).position).to eq queue_target 
      end
      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end
      it "creates nothing if already created" do
        expect {
          post :create, user_id: user.id, video_id: video.id
        }.to change(QueueItem, :count).by(0)
      end
    end

    it "redirects to login page if no logging in" do
      session[:user_id] = nil
      post :create, user_id: user.id, video_id: video.id
      expect(response).to redirect_to root_path      
    end
  end

  describe "queues#index" do
    context "logged in" do
      before do
        session[:user_id] = user.id
        queue_item = QueueItem.create(
          video: video,
          user: user,
          position: queue_target
        ) 
        delete :destroy, id: queue_item
      end
      it "deletes requested queue_item" do
        expect(QueueItem.count).to eq 0
      end
      it "rearranges list order to right order"
      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end
    end
    it "redirects to root_path if no logging in" do
      session[:user_id] = nil
      queue_item = QueueItem.create(
        video: video,
        user: user,
        position: queue_target
      ) 
      delete :destroy, id: queue_item
      expect(response).to redirect_to root_path 
    end
    it "do nothing if it is not current user's queue" do
      user2 = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = QueueItem.create(
        video: video,
        user: user2,
        position: queue_target
      ) 
      expect{
        delete :destroy, id: queue_item
      }.to change(QueueItem, :count).by(0)
    end
  end
end
