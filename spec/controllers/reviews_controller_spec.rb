require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do
      context "with invalid inputs"

        it "redirect to the video show page" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video 
        end

        it "creates a review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1) 
          
        end
       
        it "creates a review associated with the video"
        it "creates a review associated with the user"
      context "with invalid inputs"
    end
    context "with unauthenticated users" 
  end
end
