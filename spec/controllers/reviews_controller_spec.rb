require 'spec_helper'

describe ReviewsController do

  describe "POST create" do
    context "with authenticated users" do
      context "with valid input" do
        it "redirects to the video show page" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate.attributes_for(:review), video_id: video
          expect(response).to redirect_to video_path(video)

        end

        it "creates a review" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate.attributes_for(:review), video_id: video
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate.attributes_for(:review), video_id: video
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the signed in user" do
          current_user = Fabricate(:user)
          session[:user_id] = current_user.id
          video = Fabricate(:video, title: "South Park")

          post :create, review: Fabricate.attributes_for(:review), video_id: video, user_id: current_user
          expect(Review.first.user).to eq(current_user)
        end
      end

      context "with invalid input" do
        it "does not create a review"
        it "renders the videos/show template" 
        it "sets @video"
        it "sets @review"
      end
    end
    context "with unauthenticated users"
  end
end