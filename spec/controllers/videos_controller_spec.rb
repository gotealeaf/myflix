require 'spec_helper'

describe VideosController do 
  
  describe "GET show" do
    it "sets the @video variable when user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video, title: "South Park")

      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects user when inauthenticated" do
      video = Fabricate(:video, title: "South Park")
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

    context "when the user has not reviewed the video" do
      it "sets a @review variable" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video, title: "South Park")
        review = Fabricate.build(:review)

        get :show, id: video.id
        expect(assigns(:review)).to be_instance_of(Review)
      end
    end
  end

  describe "GET search" do
    it "redirects user when inauthenticated" do
      south_park = Fabricate(:video, title: "South Park")
      
      get :search
      expect(response).to redirect_to sign_in_path
    end

    it "sets the @results variable by search term when user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      results = Fabricate(:video, title: "South Park")

      get :search, search_term: 'park'
      expect(assigns(:results)).to match_array([results])
    end

  end
end