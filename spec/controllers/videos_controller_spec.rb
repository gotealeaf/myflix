require 'spec_helper'

describe VideosController do

  describe "videos#show" do
    before(:each) do
      @video = Fabricate(:video)
    end
    it "assigns specific video to @video by id when logon" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: @video.id
      expect(assigns(:video)).to eq @video
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :show, id: @video.id
      expect(response).to redirect_to root_path
    end
  end  

  describe "videos#search" do
    before(:each)  do
      @videos = Fabricate(:video)
    end
    it "assigns specific videos to @videos by search_item" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_item: @videos.title 
      expect(assigns(:videos)).to eq [@videos]
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :search, search_item: @videos.title 
      expect(response).to redirect_to root_path
    end 
  end


  describe "videos#review" do
    context "logged in" do
      before(:each) do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end

      context "data pass validate" do
        before(:each) do
          @video = Fabricate(:video)
          @review = Fabricate.build(:review)
          post :review, id: @video.id, rating: @review.rating, review_description: @review.review_description
        end
        it "assigns rating to @review" do
          expect(assigns(:review).rating).to eq @review.rating
        end
        it "assigns review_description to @review" do
          expect(assigns(:review).review_description).to eq @review.review_description
        end
        it "assigns video to @review" do
          expect(assigns(:review).video).to eq @video
        end
        it "assigns current user to @review" do
          expect(assigns(:review).user).to eq @user
        end
        it "save reviews to db when validation success" do
          expect(Review.count).to eq 1
        end
        it "render :show" do
          expect(response).to render_template :show
        end
      end
      
      context "data not pass validate" do
        before(:each) do
          @video = Fabricate(:video)
          post :review, id: @video.id, rating: nil, review_description: ""
        end
        it "does not save review to db" do
          expect(Review.count).to eq 0
        end
      end
    end  

    context "not logged in" do
      before(:each) do
        @video = Fabricate(:video)
        @review = Fabricate.build(:review)
        post :review, id: @video.id, rating: @review.rating, review_description: @review.review_description
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
