require 'spec_helper'

describe VideosController do
  describe "Get show" do
    it "sets @video when logged in" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "redirects the user to the sign-in page if not authenticated" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "Post search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, name: "Futurama")
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end
    it "redirects the user to the sign-in page if not authenticated" do
       futurama = Fabricate(:video, name: "Futurama")
       post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end
