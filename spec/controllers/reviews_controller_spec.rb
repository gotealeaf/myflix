require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do


      let (:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context "with valid inputs" do
        it "creates a review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with the video" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with the signed in user" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.user).to eq(current_user)
        end
        it "redirects back to video show page" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video
        end
      end
      context "with invalid inputs"
    end
    context "with unauthenticated users"
  end
end
