require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) {Fabricate(:video)}

    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id] = current_user.id}
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

      end
    end

    context "with unauthorized users" do
      it "no authorization cannot post review"
    end
  end
end