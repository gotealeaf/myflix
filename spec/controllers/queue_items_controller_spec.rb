require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }

  describe "GET index" do
    it "redirects to sign_in_path with unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end

    context "with authenticated users" do
      before :each do
        session[:user_id] = user
        @queue_item_1 = Fabricate(:queue_item, user: user)
        @queue_item_2 = Fabricate(:queue_item, user: user)
        get :index
      end

      it "sets @queue_items" do
        expect(assigns(:queue_items)).to match_array([@queue_item_1, @queue_item_2])
      end

      it "renders queue template" do
        expect(response).to render_template 'users/my_queue'
      end
    end
  end

  describe "POST create" do
    it "redirects to sign_in_path with unauthenticated users" do
      post :create
      expect(response).to redirect_to sign_in_path
    end

    context "with authenticated users" do
      let(:video) { Fabricate(:video) }

      context "video is not in user queue" do
        before :each do
          session[:user_id] = user
          post :create, video_id: video.id
        end

        it "creates queue_item associated with video and user" do
          expect(QueueItem.first.video).to eq video
          expect(QueueItem.first.user).to eq user
        end

        it "redirects to my_queue path" do
          expect(response).to redirect_to(my_queue_path)
        end
      end

      context "video is in user queue" do
        before :each do
          session[:user_id] = user
          Fabricate(:queue_item, video: video, user: user)
          post :create, video_id: video.id
        end

        it "does not save the queue_item" do
          expect(QueueItem.count).to eq 1
        end

        it "sets warning message" do
          expect(flash[:warning]).to_not be_blank
        end

        it "redirects to video page" do
          expect(response).to redirect_to video
        end
      end
    end
  end
end