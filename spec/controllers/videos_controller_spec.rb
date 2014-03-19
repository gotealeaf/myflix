require 'spec_helper'

describe VideosController do
  describe "GET show" do

    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end   

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2]) 
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
