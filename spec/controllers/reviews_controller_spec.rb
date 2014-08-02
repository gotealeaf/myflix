require 'spec_helper'

describe ReviewsController do
  let(:current_user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  describe "POST create" do

    context "authenticated user" do

      before { session[:user_id] = current_user.id }

      context "valid inputs" do

        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the signed in user" do
          expect(Review.first.creator).to eq(current_user)
        end

        it "redirects to to video show page" do
          expect(response).to redirect_to video
        end
      end

      context "invalid inputs" do

        before do
          session[:user_id] = current_user.id
          post :create, review: { rating: 4 }, video_id: video.id
        end

        it "does not create a review" do
          expect(Review.count).to eq(0)
        end

        it "render template video/show" do
          expect(response).to render_template "videos/show"
        end

        it "assigns @video" do
          expect(assigns(:video)).to eq(video)
        end
      end
    end

    context "unauthenticated user" do
      it 'redirect to sign in page' do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to signin_path
      end
    end
  end
end
