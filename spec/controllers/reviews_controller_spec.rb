require "rails_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do

      let (:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context "with valid input" do
        it "redirects to the video show page" do 
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video
        end
        it "creates a review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end
        it "it creates a review associated with video" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end

        it "it creates a review associated with the signed in user" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.user).to eq(current_user)
        end
        

      end
      context "with invalid input"
    end
    context "with unathenticated user"
  end
end