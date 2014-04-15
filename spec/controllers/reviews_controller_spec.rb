require 'spec_helper'

describe ReviewsController do
  before { set_current_user }

  describe "POST create" do
    context "with unauthenticated users" do
      let(:video) { Fabricate(:video) }

      it_behaves_like "require_sign_in" do
        let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
      end

      it "does not set @review" do
        clear_current_user
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(assigns(:review)).to be_nil
      end
    end

    context "with authenticated users" do
      context "with invalid data" do
        let(:video) { Fabricate(:video) }
        let(:review_1) { Fabricate(:review, user: current_user, video: video, rating: 3) }
        let(:review_2) { Fabricate(:review, user: current_user, video: video, rating: 3) }
        let(:review_3) { Fabricate(:review, user: current_user, video: video, rating: 4) }
        let(:action) { post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id }

        it "renders to videos/show" do
          action
          expect(response).to render_template 'videos/show'
        end

        it "sets @average_rating with no reviews" do
          action
          expect(assigns(:average_rating)).to eq "Not yet reviewed."
        end

        it "sets @video" do
          action
          expect(assigns(:video)).to eq video
        end

        it "raises errors on @review" do
          action
          expect(assigns(:review)).to have(1).error_on(:content)
        end

        it "does not save the review" do
          action
          expect(Review.count).to eq 0
        end

        it "sets @reviews to the reviews for the current video" do
          review_1; review_2; review_3
          action
          expect(assigns(:reviews)).to match_array video.reviews
        end

        it "sets @average_rating to the videos average rating rounded 1 place" do
          review_1; review_2; review_3
          action
          expect(assigns(:average_rating)).to eq 3.3
        end
      end

      context "with valid data" do
        let(:video) { Fabricate(:video) }

        before :each do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "saves the review" do
          expect(Review.first).to be_instance_of Review
        end

        it "sets @review.video" do
          expect(assigns(:video)).to eq video
        end

        it "redirects to the video's show path" do
          expect(response).to redirect_to video_path(video.id)
        end
      end
    end
  end
end