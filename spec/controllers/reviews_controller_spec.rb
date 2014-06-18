require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) {Fabricate(:video)}

    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id] = current_user}
      context "with valid imputs" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
        it "redirects to the video show page" do
          expect(response).to redirect_to video
        end
        it "creates a review" do
          expect(Review.count).to eq(1)
        end
        it "creates a review association with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "creates a review association with the user" do
          expect(Review.first.user).to eq(current_user)
        end
      end
      context "with invalid input" do
        it "does not create a review" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(Review.count).to eq(0)
        end
        it "renders the videos/show template" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(response).to render_template "videos/show"
        end
        it "sets the @video" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
        it "sets the @reviews" do
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "with unauthorized users" do
      before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end
      it "cannot post review" do
        expect(Review.count).to eq(0)
      end
    end
  end
end