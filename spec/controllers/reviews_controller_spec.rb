require 'rails_helper'

describe ReviewsController do
  describe "POST create" do

    it "should redirect to sign_in if user not signed in" do
      video = Fabricate(:video)
      post :create, video_id: video, review: { rating: 2, content: 'Testing' }
      expect(response).to redirect_to(sign_in_path)
    end

    context "with valid values" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        cookies[:auth_token] = user.auth_token
        post :create, video_id: video, review: { rating: 2, content: 'Testing' }
      end
      
      it "should create a new review with correct values" do
        expect(Review.count).to eq(1)
      end
      it "should create a review for the correct video" do
        expect(Review.first.video).to eq(video)
      end
      it "should create a review for the correct user" do
        expect(Review.first.user).to eq(user)
      end
      it "should set the flash message correctly" do
        expect(flash[:success]).not_to be_blank
      end
      it "should redirect to the video page if successful" do
        expect(response).to redirect_to video_path(Video.first)
      end
    end

    context "with invalid values" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        cookies[:auth_token] = user.auth_token
        post :create, video_id: video, review: { rating: nil, content: 'Testing' }
      end
      it "should NOT create a review with incomplete values" do
        expect(Review.count).to eq(0)
      end
      it "should set the flash error message" do
        expect(flash.now[:error]).not_to be_blank
      end
      it "render the videos show page if there is an error" do
        expect(response).to render_template('videos/show')
      end
      it "sets @video for the show template" do
        expect(assigns(:video)).not_to be_nil
      end
      it "sets @reviews for the show template" do
        review = Fabricate(:review, video: video, user: user)
        expect(assigns(:reviews)).not_to match_array([review])
      end
    end
  end
end
