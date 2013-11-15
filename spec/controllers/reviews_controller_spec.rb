require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do

      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context "with valid input" do
        it "redirects to the video show page" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video_path(video)
        end
        it "creates a review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq 1
        end
        it "creates a review associated with the video" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq video
        end

        it "creates a review associated with the signed in user" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review, user_id: current_user.id), video_id: video.id
          expect(Review.first.user_id).to eq current_user.id
        end
        
      end
      context "with invalid input" do
        it "doesn't create a review" do
          video = Fabricate(:video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(Review.count).to eq 0
        end
        it "renders the video/show template" do
          video = Fabricate(:video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(response).to render_template "videos/show"
        end
        it "sets @video" do
          video = Fabricate(:video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          video = Fabricate(:video)
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "with unauthenticated user" do 
      it "redirects to the sign in path" do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path 
      end
    end
  end

end