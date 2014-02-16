require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, review: { rating: 3 }, video_id: video.id }
    end

    context "with authenticated users" do
      let(:alice) { Fabricate(:user) }
      before { set_current_user(alice) }

      context "with valid input" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }

        it "redirects to the video show page" do
          expect(response).to redirect_to video
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the assigned user" do
          expect(Review.first.user).to eq(alice)
        end
      end

      context "with invalid input" do
        before { post :create, review: { rating: 3 }, video_id: video.id }

        it "does not create a review" do
          expect(Review.count).to eq(0)
        end

        it "renders the video show template" do
          expect(response).to render_template "videos/show"
        end

        it "sets @video" do
          expect(assigns(:video)).to eq(video)
        end

        it "sets @reviews" do
          review = Fabricate(:review, video: video)
          post :create, review: { rating: 3 }, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
  end
end
