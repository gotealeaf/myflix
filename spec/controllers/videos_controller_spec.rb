require 'spec_helper'

describe VideosController do
    
  describe "GET show" do  
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects unauthenticated users to login page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to :sign_in
    end
  end
    
  describe "GET search" do
    it "sets @videos for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      star_wars = Fabricate(:video, title: "Star Wars")
      get :search, search_term: "star"
      expect(assigns(:videos)).to eq([star_wars])
    end
    it "redirects unauthenticated users to login page" do
      star_wars = Fabricate(:video, title: "Star Wars")
      get :search, search_term: "star"
      expect(response).to redirect_to :sign_in
    end
  end
  
end