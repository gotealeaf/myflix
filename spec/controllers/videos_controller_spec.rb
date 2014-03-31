require 'spec_helper'

describe VideosController do
  describe "GET index" do
    it "redirects to sign_in_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end

    it "sets @categories with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :index
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

  describe "GET show" do
    before :each do
      @fake_video = Fabricate(:video)
    end

    it "redirects to the sign_in_path for unauthenticated users" do
      get :show, id: @fake_video.id
      expect(response).to redirect_to(sign_in_path)
    end

    it "sets @avg_rating to 3 if no reviews with authenticated users" do
      @user = Fabricate(:user)
      session[:user_id] = @user.id
      get :show, id: @fake_video.id
      expect(assigns(:avg_rating)).to eq(3)
    end

    context "with authenticated users" do
      before :each do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
        @review_1 = Fabricate(:review, user: @user, video: @fake_video, rating: 3)
        @review_2 = Fabricate(:review, user: @user, video: @fake_video, rating: 3)
        @review_3 = Fabricate(:review, user: @user, video: @fake_video, rating: 4)
        get :show, id: @fake_video.id
      end

      it "sets @reviews" do
        expect(assigns(:reviews)).to match_array([@review_1, @review_2, @review_3])
      end

      it "sets @video" do
        expect(assigns(:video)).to eq(@fake_video)
      end

      it "sets @user" do
        expect(assigns(:user).id).to eq(session[:user_id])
      end

      it "sets @avg_rating rounded 1 place" do
        expect(assigns(:avg_rating)).to eq(3.3)
      end

      it "sets @review to be a new Review object" do
        expect(assigns(:review)).to be_a_new(Review)
      end
    end
  end

  describe "GET search" do
    before :each do
      @futurama = Fabricate(:video, title: "Futurama")
    end

    it "redirects to sign_in_path with unauthenticated users" do
      get :search, search_term: "futurama"
      expect(response).to redirect_to(sign_in_path)
    end

    it "sets @results with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_term: "futurama"
      expect(assigns(:results)).to eq([@futurama])
    end
  end
end








