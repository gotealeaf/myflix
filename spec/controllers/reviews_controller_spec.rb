require 'spec_helper'

describe ReviewsController do

  describe 'POST create' do
    let(:video) { Fabricate(:video) } #makes one whenever it's called

    context "with guest (not signed in)" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) {post :create, review: Fabricate.attributes_for(:review), video_id: 1}
      end
    end

    context "with signed in user" do
      let(:current_user) { Fabricate(:user) }
      before             { session[:user_id] = current_user.id }

      context "with valid inputs" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }

        it "filters the parameters via strong_params method review_params" do
          expect(@controller.instance_eval{review_params}).to include(:rating, :content)
        end
        it "loads the review variable with the parameters passed" do
          expect(assigns(:review)).to be_instance_of Review
        end
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "saves a review by user" do
          expect(Review.first.user).to eq(current_user)
        end
        it "loads the current video" do
          expect(assigns(:video)).to eq(video)
        end
        it "flashes a notice if the video was saved" do
          expect(flash[:notice]).to_not be_empty
        end
        it "redirects to the videos#show page" do
          expect(response).to redirect_to video
        end
      end

      context "with valid empty content" do
        it "accepts empty content" do
          post :create, review: Fabricate.attributes_for(:review, content: ""), video_id: video.id
          expect(Review.first.content).to eq("")
        end
      end

      context "with improper rating input" do
        before { post :create, review: Fabricate.attributes_for(:review, rating: 0), video_id: video.id }

        it "that's below 1 does not save the review into the database" do
          expect(assigns(:review)).to_not be_persisted
        end
        it "sets @video" do
          expect(assigns(:video)).to eq(video)
        end
        it "redirects back to video#show page again" do
          expect(response).to redirect_to video
        end
        it "shows the users form errors"
      end

      context "user attempts second review on video" do
        it "does not save the review"
        it "re-renders the page"
        it "flashes notice that user has already reviewed the video"
      end
    end
  end
end
