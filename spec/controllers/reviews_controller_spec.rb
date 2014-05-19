require 'spec_helper'

describe ReviewsController do
  context "for an authenticated user" do
    let(:video) {Fabricate(:video)}
    let(:user) {Fabricate(:user)}
    before do
      session[:user_id] = user.id
    end
    
    context "with valid inputs" do
      before {post :create, review: {rating: 2, content: 'My Review'}, video_id: video.id}
      it "creates a review" do
        expect(Review.count).to eq(1)
      end
      it "redirects to the video show page" do
        expect(response).to redirect_to(video)
      end
      it "creates a review with the associated video" do
        expect(Review.first.video).to eq(video)
      end
      it "creates a review with the associated user" do
        expect(Review.first.user).to eq(user)
      end
    end
    context "with invalid inputs" do
      before do 
        review = Fabricate(:review, video: video)
        post :create, review: {rating: 2, content: ''}, video_id: video.id
      end
      it "does not create a review" do
        expect(Review.count).to eq(1)
      end
      it "renders the video show template" do
        expect(response).to render_template('videos/show')
      end
      it "assigns @video" do
        expect(assigns(:video)).to eq(video)
      end
      it "assigns @reviews" do
        expect(assigns(:reviews)).to match_array(video.reviews)
      end
    end
    
  end

  context "for an unauthenticated user" do
    describe "POST #create" do
      it "redirects to the sign in page" do
        video = Fabricate(:video)
        post :create, review: {rating: 2, content: 'My Review'}, video_id: video.id 
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end