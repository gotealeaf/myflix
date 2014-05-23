require "spec_helper"

describe VideosController do
  describe "GET show" do
    it "assigns @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "redirects unauthenticated users to login page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST search" do
    it "assigns @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      breaking_bad = Fabricate(:video, title: "Breaking Bad")
      post :search, search: "break"
      expect(assigns(:videos)).to eq([breaking_bad])
    end

    it "redirects unauthenticated users login page" do
      breaking_bad = Fabricate(:video, title: "Breaking Bad")
      post :search, search: "break"
      expect(response).to redirect_to login_path
    end
  end
end