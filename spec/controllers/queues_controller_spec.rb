require 'spec_helper'

describe QueuesController do  

  describe "GET index" do
    context "user authenticated" do
      before do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        Fabricate(:user_video, user_id: alice.id, video_id: 1)
        get :index
      end

      it "sets @user_videos variable" do
        expect(assigns(:user_videos)).to eq(User.first.videos)
      end

      it "sets @user_reviews variable" do
        expect(assigns(:user_reviews)).to eq(User.first.reviews)
      end

      it "renders index template, my_queue page" do
        expect(response).to render_template :index
      end
    end

    context "user not authenticated" do
      before do
        alice = Fabricate(:user)
        Fabricate(:user_video, user_id: alice.id, video_id: 1)
        get :index
      end

      it "does not set @user_videos variable" do
        expect(assigns(:user_videos)).to eq(nil)
      end
      
      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST destroy" do
    context "user authenticated" do
      before do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        Fabricate(:user_video, user_id: alice.id, video_id: 1)
        Fabricate(:user_video, user_id: alice.id, video_id: 2)
        delete :destroy, id: 1
      end

      it "deletes the selected video from user_videos" do
        expect(User.first.user_videos.count).to eq(1)
      end

      it "does not delete other videos" do
        expect(User.first.user_videos.first.id).to eq(2)
      end

      it "redirects to the queue screen" do
        expect(response).to redirect_to my_queue_path
      end
    end

    context "user not authenticated" do
      before do
        alice = Fabricate(:user)
        Fabricate(:user_video, user_id: alice.id, video_id: 1)
        Fabricate(:user_video, user_id: alice.id, video_id: 2)
        delete :destroy, id: 1
      end

      it "does not delete the selected video from user_videos" do
        expect(User.first.user_videos.count).to eq(2)
      end

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end 
    end
  end
end