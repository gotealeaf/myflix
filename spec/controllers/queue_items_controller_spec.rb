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
      before do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
      end

      it "adds the video to the queue" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(User.first.queue_items.count).to eq(1)
      end

      it "sets the position to the end of the queue" do
        video = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: Video.first, user: User.first)
        post :create, video_id: video2.id
        expect(User.first.queue_items.last.video_id).to eq(video2.id)
      end

      it "redirects to my_queue index page" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
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

  # describe "POST destroy" do
  #   context "user authenticated" do
  #     before do
  #       alice = Fabricate(:user)
  #       session[:user_id] = alice.id
  #       Fabricate(:user_video, user_id: alice.id, video_id: 1)
  #       Fabricate(:user_video, user_id: alice.id, video_id: 2)
  #       delete :destroy, id: 1
  #     end

  #     it "deletes the selected video from user_videos" do
  #       expect(User.first.user_videos.count).to eq(1)
  #     end

  #     it "does not delete other videos" do
  #       expect(User.first.user_videos.first.id).to eq(2)
  #     end

  #     it "redirects to the queue screen" do
  #       expect(response).to redirect_to my_queue_path
  #     end
  #   end

  #   context "user not authenticated" do
  #     before do
  #       alice = Fabricate(:user)
  #       Fabricate(:user_video, user_id: alice.id, video_id: 1)
  #       Fabricate(:user_video, user_id: alice.id, video_id: 2)
  #       delete :destroy, id: 1
  #     end

  #     it "does not delete the selected video from user_videos" do
  #       expect(User.first.user_videos.count).to eq(2)
  #     end

  #     it "redirects to the login page" do
  #       expect(response).to redirect_to login_path
  #     end 
  #   end
  # end
end