require 'rails_helper'

describe VideosController do

  describe "GET show" do

    it "sets @video if user is signed in" do
      cookies[:auth_token] = Fabricate(:user).auth_token
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "sets @reviews for signed in users" do
      user = Fabricate(:user)
      cookies[:auth_token] = user.auth_token
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, user: user)
      review2 = Fabricate(:review, video: video, user: user)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1,review2])
    end

    it "sets @new_review if user is signed in" do
      cookies[:auth_token] = user = Fabricate(:user).auth_token
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:new_review)).to be_instance_of(Review)
    end

    it "redirects user to sign in page if not signed in" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

  end

  describe "GET search" do
    it "sets @videos if user signed in" do
      cookies[:auth_token] = Fabricate(:user).auth_token
      batman = Fabricate(:video, title: "Batman")
      get :search, search_term: 'bat'
      expect(assigns(:videos)).to eq([batman])
    end

    it "redirects to sign in if user not signed in" do
      Fabricate(:video, title: "Superman")
      get :search, search_term: 'man'
      expect(response).to redirect_to sign_in_path
    end
  end

end
