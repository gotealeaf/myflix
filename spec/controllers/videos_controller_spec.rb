require 'rails_helper.rb'

describe VideosController do
  describe "GET show" do
    it "sets @video if user authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews if user authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
      # =~ matches array contents but not in order, match_array same
      # assigns(:reviews).should =~ [review1, review2]
    end

    it "redirects to sign in if user unauthenticated" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets @results if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :search, search_term: video.title
      expect(assigns(:results)).to eq([video])
    end

    it "redirects to sign in if user is unauthenticated" do
      video = Fabricate(:video)
      post :search, search_term: video.title
      expect(assigns(:results)).to redirect_to sign_in_path
    end
  end
end
