require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with unauthenticated users" do
      it "redirects to login path" do
        post :create, video_id: Fabricate(:video).id, review: Fabricate.attributes_for(:review)
        expect(response).to redirect_to login_path
      end
    end

    context "with authenticated users" do
      it "sets the @review variabel for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        post :create, video_id: Fabricate(:video).id, review: Fabricate.attributes_for(:review)
        expect(assigns(:review)).to be_instance_of(Review)
      end
      it "sets @review with the video" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(assigns(:review).video).to eq(video)
        end
      it "sets @review with current user" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(assigns(:review).user).to eq(user)
      end
      context "with valid input" do
        it "creates a review" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(Review.count).to eq(1)
        end
        it "redirects to video show path" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(response).to redirect_to video_path(video)
        end
      end
      context "with invalid input" do
        it "does not creates a review" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review, content: '')
          expect(Review.count).to eq(0)
        end
        it "renders show path" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review, content: '')
          expect(response).to render_template 'videos/show'
        end
        it "sets @video" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review, content: '')
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          user = Fabricate(:user)
          video = Fabricate(:video)
          review = Fabricate(:review, user: user, video: video)
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review, content: '')
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
  end
end
