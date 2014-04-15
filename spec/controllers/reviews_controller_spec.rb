require 'spec_helper'

describe ReviewsController do

  let(:user)  { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  describe "reviews#create" do
    context "logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      context "data pass validation" do
        before(:each) do
          @review = Fabricate.build(:review)
          post :create, id: video.id, rating: @review.rating, review_description: @review.review_description
        end
        it "assigns rating to @review" do
          expect(assigns(:review).rating).to eq @review.rating
        end
        it "assigns review_description to @review" do
          expect(assigns(:review).review_description).to eq @review.review_description
        end
        it "assigns video to @review" do
          expect(assigns(:review).video).to eq video
        end
        it "assigns current user to @review" do
          expect(assigns(:review).user).to eq user
        end
        it "save reviews to db when validation success" do
          expect(Review.count).to eq 1
        end
        it "redirect_to videos#show " do
          expect(response).to redirect_to "videos#show"
        end
      end
      
      context "data not pass validation" do
        before(:each) do
          post :create, id: video.id, rating: nil, review_description: ""
        end
        it "does not save review to db" do
          expect(Review.count).to eq 0
        end
      end
    end  

    context "not logged in" do
      before(:each) do
        @review = Fabricate.build(:review)
        post :create, id: video.id, rating: @review.rating, review_description: @review.review_description
      end

      it "does not save rview to db" do
        expect(Review.count).to eq 0
      end
      it "redirects to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end

end
