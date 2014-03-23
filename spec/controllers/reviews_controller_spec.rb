require 'spec_helper'

describe ReviewsController do
  describe "POST 'create'" do

    context "not signed in" do
      let(:review) { Fabricate.build(:review, video: Fabricate(:video)) }

      before do
        post :create, video_id: review.video.id, review: { rating: review.rating, comment: review.comment }
      end

      it "does not create review" do
        Review.last.should_not == review
      end

      it "redirects back to sign_in_path" do
        response.should redirect_to(sign_in_path)
      end

    end

    context "after signed in" do
      let(:video) { Fabricate(:video) }
      let(:user) { Fabricate(:user) }
      let(:review) { Fabricate.build(:review, id: 1, video: video, user: user) }


      context "with valid inputs" do
        before do
          session[:user_id] = user.id
          post :create, video_id: review.video.id, review: { rating: review.rating, comment: review.comment }
        end

        it "creates reveiw" do
          assigns(:new_review).errors.to_a.should be_empty
          Review.last.should == review
        end

        it "redirect back to video show page" do
          response.should redirect_to(video_path(review.video.id))
        end
      end

      context "with invalid inputs" do
        before do
          session[:user_id] = user.id
          post :create, video_id: review.video.id, review: { rating: review.rating, comment: "" }
        end

        it "does not create reveiw" do
          assigns(:new_review).errors.to_a.should be_present
          Review.last.should be_nil
        end

        it "renders video show page" do
          response.should render_template("videos/show")
        end
      end

    end
  end
end
