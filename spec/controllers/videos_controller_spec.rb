require "rails_helper"

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects unathenticated users to the landing page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end # GET show

  describe "POST search" do
    it "sets @search_results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      wolves = Fabricate(:video, title: "Dances with Wolves")
      post :search, search_term: "dance"
      expect(assigns(:search_results)).to eq([wolves])
    end
    it "redirects to landing page for unathenticated users" do
      wolves = Fabricate(:video, title: "Dances with Wolves")
      post :search, search_term: "dance"
      expect(response).to redirect_to root_path
    end
  end # POST search
end