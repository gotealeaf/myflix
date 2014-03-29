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

    context "with authenticated users"
      before :each do
        @review_1 = Fabricate(:review, video: @fake_video)
        @review_2 = Fabricate(:review, video: @fake_video)
        session[:user_id] = Fabricate(:user).id
        get :show, id: @fake_video.id
      end

      it "sets @reviews" do
        execpt(assigns(:reviews)).to match_array([@review_1, @review_2])
      end

      it "sets @video" do
        expect(assigns(:video)).to eq(@fake_video)
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