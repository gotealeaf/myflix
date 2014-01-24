require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    let(:video) { Fabricate(:video) }
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      context "with valid inputs" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
        it "redirects to the video show page" do
          expect(response).to redirect_to video
        end
        it "creates a review" do
          expect(Review.count).to eq 1
        end
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq (video)
        end
        it "creates a review associated with the signed-in user" do
          expect(Review.first.user).to eq (current_user)
        end
      end
      context "with invalid inputs" do
        it "does not create a review" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(Review.first).to be_nil
        end
        it "renders the video/show template" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(response).to render_template "videos/show"
        end
        it "sets @video" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          review = Fabricate(:review, video: video, user: Fabricate(:user))
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
    context "with unauthenticated users" do
      it "redirects to the sign-in path" do
        post :create, review: Fabricate.attributes_for(:review, user: Fabricate(:user)), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
      it "must be a logged in user" do
        session[:user_id] = nil
        post :create, video_id: Fabricate(:video).id, review: {body: "Great video!", rating: 5}
        expect(Review.count).to eq 0
      end
    end
  end
end