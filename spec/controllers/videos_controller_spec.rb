require 'spec_helper'

describe VideosController do 
  
  describe "GET show" do
    it "sets the @video variable" do
      session[:user_id] = Fabricate(:user).id
      south_park = Fabricate(:video)

      get :show, id: video.id
      expect(assigns(:video)).to eq(south_park)
    end
    it "renders the show template" do
      session[:user_id] = Fabricate(:user).id
      south_park = Fabricate(:video)
      get :show, id: 1
      expect(response).to render_template :show
    end
  end

  describe "GET search" do
    it "renders the search template" do
      session[:user_id] = Fabricate(:user).id
      south_park = Fabricate(:video)
      
      get :search
      expect(response).to render_template :search
    end

    it "sets the @results variable by search term" do
      session[:user_id] = Fabricate(:user).id
      results = Fabricate(:video, title: "South Park")

      get :search, search_term: 'park'
      expect(assigns(:results)).to match_array([results])
    end

  end
end