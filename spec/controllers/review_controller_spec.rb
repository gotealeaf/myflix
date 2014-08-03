require 'spec_helper'

describe ReviewsController do
  describe "not a user" do
    it "redirects to sign in path" do
      video = Fabricate(:video)
      post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "sets @video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      expect(assigns(:video)).to eq(video)
    end
 
    it "sets @review" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review = video.reviews.build(rating: 5, content: "Best movie ever.  Best review ever.  Best reviewer ever.")
      post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
      expect(assigns(:review).rating).to eq(review.rating)      
      expect(assigns(:review).content).to eq(review.content)
    end

    it "sets @review.user to the current user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review = video.reviews.build(rating: 5, content: "Best movie ever.  Best review ever.  Best reviewer ever.")
      review.user = User.find(session[:user_id])
      post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
      expect(assigns(:review).user).to eq(review.user)
    end

    context "if review attributes are valid" do
      it "creates a new review" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review = video.reviews.build(rating: 5, content: "Best movie ever.  Best review ever.  Best reviewer ever.")
        post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
        expect(Review.count).to eq(1)
    end

      it "sets the flash notice" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review = video.reviews.build(rating: 5, content: "Best movie ever.  Best review ever.  Best reviewer ever.")
        post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
        expect(flash[:notice]).not_to be_blank
      end

      it "redirects to the video path" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review = video.reviews.build(rating: 5, content: "Best movie ever.  Best review ever.  Best reviewer ever.")
        post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
        expect(response).to redirect_to video_path(assigns(:video))
      end
    end
    context "if review attributes are not valid" do
      it "does not create a new review" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review = video.reviews.build(content: "Best movie ever.  Best review ever.  Best reviewer ever.")
        post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
        expect(Review.count).to eq(0)
      end

      it "renders videos/show" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review = video.reviews.build(content: "Best movie ever.  Best review ever.  Best reviewer ever.")
        post :create, video_id: video.id, review: {rating: review.rating, content: review.content}
        expect(response).to render_template 'videos/show'

      end
    end
  end
end