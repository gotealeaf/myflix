require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with unauthenticated users" do
      it "redirects to the sign_in_path" do
        post :create
        expect(response).to redirect_to(sign_in_path)
      end

      it "does not set @review" do
        post :create
        expect(assigns(:review)).to be_nil
      end
    end

    context "with authenticated users" do
      it "sets @video" do
        expect(assigns(:video)).to eq(@fake_video)
      end

      it "sets @avg_rating to 3 if no reviews with invalid data" do
        session[:user_id] = Fabricate(:user)
        @user = User.find(session[:user_id])
        @video = Fabricate(:video)
        @fake_review = Fabricate.attributes_for(:review, content: nil, video: @video, user: @user)
        post :create, review: @fake_review
        expect(assigns(:avg_rating)).to eq(3)
      end

      context "with invalid data" do
        before :each do
          session[:user_id] = Fabricate(:user)
          @user = User.find(session[:user_id])
          @video = Fabricate(:video)
          @review_1 = Fabricate(:review, user: @user, video: @video, rating: 3)
          @review_2 = Fabricate(:review, user: @user, video: @video, rating: 3)
          @review_3 = Fabricate(:review, user: @user, video: @video, rating: 4)
          @fake_review = Fabricate.attributes_for(:review, content: nil, video: @video, user: @user)
          post :create, review: @fake_review
        end

        it "raises errors on @review" do
          expect(assigns(:review)).to have(1).error_on(:content)
        end

        it "does not save review" do
          expect(Review.count).to eq(3)
        end

        it "sets @reviews" do
          expect(assigns(:reviews)).to match_array([@review_1, @review_2, @review_3])
        end

        it "sets @user" do
          expect(assigns(:user)).to eq(@user)
        end

        it "sets @avg_rating rounded 1 place" do
          expect(assigns(:avg_rating)).to_not be_blank
        end

        it "renders to videos/show" do
          expect(response).to render_template('videos/show')
        end
      end

      context "with valid data" do
        before :each do
          session[:user_id] = Fabricate(:user)
          @user = User.find(session[:user_id])
          @video = Fabricate(:video)
          @fake_review = Fabricate.attributes_for(:review, video: @video, user: @user)
          post :create, review: @fake_review
        end

        it "sets @review" do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it "saves the review" do
          expect(Review.first).to be_instance_of(Review)
        end

        it "sets @review.video" do
          expect(assigns(:review).video).to eq(@video)
        end

        it "sets @review.user" do
          expect(assigns(:review).user).to eq(@user)
        end

        it "redirects to video_path" do
          expect(response).to redirect_to(video_path(@video.id))
        end
      end
    end
  end
end