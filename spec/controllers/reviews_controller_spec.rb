require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      context "with valid inputs" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
        it "redirects to the video show page" do 
          response.should redirect_to video
        end

        it "creates a review" do 
          Review.count.should be 1
        end
        it "creates a review associated with the video" do
          Video.first.reviews.should == video.reviews
        end
        it "creates a review associated with the signed in user" do
          Review.first.user.should == current_user
        end
      end
      context "with invalid inputs" do
        it "does not create a review" do
          post :create, review: {rating: 4} , video_id: video.id
          Review.count.should == 0
        end
        it "renders the videos/show template" do
          post :create, review: {rating: 4} , video_id: video.id
          response.should render_template "videos/show"
        end    
        it "sets @video" do
          post :create, review: {rating: 4} , video_id: video.id
          assigns(:video).should == video
        end
        it "sets @reviews" do
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4} , video_id: video.id
          assigns(:reviews).should == video.reviews
        end
      end
    end
    context "with unathenticated user" do
      it_behaves_like "require_sign_in" do 
        let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
      end
    end
  end
end