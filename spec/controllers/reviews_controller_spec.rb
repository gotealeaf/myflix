require 'spec_helper'
require 'pry'

describe ReviewsController do

  describe "POST create" do
    context "with authenticated users" do
      context "with valid input" do

        it "redirects to the video show page" do    
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate.attributes_for(:review, rating: 3.0), video_id: video
          expect(response).to redirect_to video_path(video)

        end

        it "creates a review" do
          video = Fabricate(:video, title: "South Park") 

          post :create, review: { user_review: "test 123", rating: 3.0}, video_id: video
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          video = Fabricate(:video)

          post :create, review: Fabricate.attributes_for(:review, rating: 3.0, video_id: video.id), video_id: video.id
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the signed in user" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate(:review, user: current_user, rating: 3.0).attributes, user_id: current_user, video_id: video
          expect(Review.first.user).to eq(current_user)
        end
      end

      context "with invalid input" do
        it "does not create a review" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: { user: current_user }, user_id: current_user, video_id: video
          expect(Review.count).to eq(0)
        end
        it "renders the videos/show template" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: { user: current_user }, user_id: current_user, video_id: video
          expect(response).to render_template 'videos/show'
        end
        it "sets @video" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video)

          post :create, review: { rating: 3.0 }, video_id: video
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video)
          review = Fabricate(:review, rating: 3.0, user_review: "yay", video: video, user_id: current_user.id)

          post :create, review: { rating: 3.0 }, video_id: video
          expect(Review.first).to eq(review)
        end
      end
    end
    context "with unauthenticated users"
  end
end