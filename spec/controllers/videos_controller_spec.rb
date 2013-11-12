require 'spec_helper'

describe VideosController do
  describe "GET show" do   
    it "sets @video for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video1 = Fabricate(:video)
      get :show, id: video1.id
      expect(assigns(:video)).to eq(video1)
    end

    it "redirect user to front page for unauthenticated user" do
      video1 = Fabricate(:video)
      get :show, id: video1.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets @results for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: "ura"
      expect(assigns(:videos)).to eq([futurama])
    end

    it "redirects to sign in page for unauthenticated user" do
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: "ura"
      expect(response).to redirect_to sign_in_path
    end
  end

end