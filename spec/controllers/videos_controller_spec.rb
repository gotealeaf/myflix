require 'spec_helper'

describe VideosController do
  describe "GET show" do

    it "sets the @video variable if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end   

   it "redirects unauthenticated users to the sign in page" do
     video = Fabricate(:video)
     get :show, id: video.id
     expect(response).to redirect_to :sign_in
   end
  end

  describe "GET search" do
    it "sets @results for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      monk = Fabricate(:video, title: "Monk")
      get :search, search_term: "onk"
      expect(assigns(:results)).to eq([monk])
    end

    it "redirects unauthenticated users to the sign in page" do
      monk = Fabricate(:video, title: "Monk")
      get :search, search_term: "onk"
      expect(response).to redirect_to :sign_in
    end
  end
end
