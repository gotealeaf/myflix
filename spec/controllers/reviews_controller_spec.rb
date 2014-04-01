require 'spec_helper'
require 'pry'

describe ReviewsController do
  describe "POST create" do
    let(:bob) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }    
    context "with authenticated users" do

        before do
          set_current_user(bob)
        end

      context "with valid input" do
        it "redirects to the video show page" do    
          post :create, review: {rating: 3.0}, video_id: video
          expect(response).to render_template('videos/show')
        end

        it "creates a review" do         
          post :create, review: { content: "test 123", rating: 3.0}, video_id: video.id
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do                    
          post :create, review: Fabricate.attributes_for(:review, rating: 3.0, video_id: video.id), video_id: video.id
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the signed in user" do                
          post :create, review: {user: bob, rating: 3.0, content: "test"}, user_id: bob.id, video_id: video.id
          expect(Review.first.user).to eq(bob)
        end
      end

      context "with invalid input" do
        it "does not create a review" do
          post :create, review: { user: bob }, user_id: bob.id, video_id: video.id
          expect(Review.count).to eq(0)
        end

        it "renders the videos/show template" do
          post :create, review: { user: bob }, user_id: bob.id, video_id: video.id
          expect(response).to render_template 'videos/show'
        end

        it "sets video" do
          post :create, review: { rating: 3.0 }, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end

        it "sets @reviews" do
          review = Fabricate(:review, rating: 3.0, content: "yay", video: video, user_id: bob.id)

          post :create, review: { rating: 3.0 }, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, review: { rating: 3.0, content: "test" }, video_id: video}
    end
  end
end