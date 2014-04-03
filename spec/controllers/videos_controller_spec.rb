require 'spec_helper'

describe VideosController do
  let(:user) { Fabricate(:user) }

  describe "GET index" do
    it "redirects to sign_in_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end

    it "sets @categories with authenticated users" do
      session[:user_id] = user
      get :index
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

  describe "GET show" do
    let(:video) { Fabricate(:video) }

    it "redirects to the sign_in_path for unauthenticated users" do
      get :show, id: video.id
      expect(response).to redirect_to(sign_in_path)
    end

    it "sets @average_rating if no reviews with authenticated users" do
      session[:user_id] = user.id
      get :show, id: video.id
      expect(assigns(:average_rating)).to eq("Not yet reviewed.")
    end

    context "with authenticated users" do
      before :each do
        session[:user_id] = user.id
        @review_1 = Fabricate(:review, user: user, video: video, rating: 3)
        @review_2 = Fabricate(:review, user: user, video: video, rating: 3)
        @review_3 = Fabricate(:review, user: user, video: video, rating: 4)
        get :show, id: video.id
      end

      it "sets @reviews" do
        expect(assigns(:reviews)).to match_array([@review_1, @review_2, @review_3])
      end

      it "sets @video" do
        expect(assigns(:video)).to eq(video)
      end

      it "sets @average_rating rounded 1 place" do
        expect(assigns(:average_rating)).to eq(3.3)
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
      session[:user_id] = user.id
      get :search, search_term: "futurama"
      expect(assigns(:results)).to eq([@futurama])
    end
  end
end








