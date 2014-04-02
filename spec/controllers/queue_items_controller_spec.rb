require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user) }
      let(:video)        { Fabricate(:video) }
      let(:queue_item)   { Fabricate(:queue_item, video: video, user: current_user) }

      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "loads the current_user's @queue_items variable" do
        expect(assigns(:queue_items)).to eq([queue_item])
      end
      it "renders the index page" do
        expect(response).to render_template :index
      end
    end

    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end
  end


  describe 'POST create' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user)  }
      let(:video)        { Fabricate(:video) }

      before do
        session[:user_id] = current_user.id
      end

      it "creates a valid queue item" do
        post :create, video_id: video.id
        expect(assigns(:queue_item)).to be_valid
      end
      it "loads the @video instance variable with the video" do
        post :create, video_id: video.id
        expect(assigns(:video)).to eq(video)
      end
      it "creates a new queue item associated with the user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user_id).to eq(current_user.id)
      end
      it "creates a new queue item associated with the video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video_id).to eq(video.id)
      end
      it "flashes an error message that video is already in the queue for duplicate attempts" do
        post :create, video_id: video.id
        expect(flash[:notice]).to_not be_nil
      end
      it "redirects to the MyQueue page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "chooses the next position number in the list" do
        video1      = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: current_user, video: video1, position: 1)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq(2)
      end
      it "does not allow duplicate videos in the view" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(assigns(:queue_item)).to_not be_valid
      end
      it "flashes an error message that video is already in the queue for duplicate attempts" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(flash[:error]).to_not be_nil
      end
      it "redirects back to the videos#show page after duplicate queue attempts" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(response).to redirect_to video
      end
    end
    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page"
    end
  end
end
