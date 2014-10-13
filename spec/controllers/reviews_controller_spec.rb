require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "athenticated users" do
      context "the data is valid" do
        it "creates a review" do
          video = Fabricate(:video)
          post :create, Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end
        it "associates the review with the video"
        it "associates the review with the current user"
        it "saves the review"
        it "redirects to the 'video/show' page"
      end
      context "the data is not valid" do
        it "does not save the review"
        it "renders the 'video/show' page"
        it "shows the errors"
      end
    end
    context "unauthenticated users" do
      it "redirects to the sign-in page"
    end    
  end
end