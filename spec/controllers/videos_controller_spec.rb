require 'spec_helper'

describe VideosController do
  before do
    session[:user_id] = Fabricate(:user).id
  end
  describe 'GET index' do
    it "builds a Categories collection" do
      biographies = Fabricate(:category, name: "Biographies")
      romantic_dramas = Fabricate(:category, name: "Romantic Dramas")
      get :index
      expect(assigns(:categories).first).to eq biographies
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
    it "redirects to sign_in path if not logged in" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  describe 'GET show' do
    it "finds a video for authenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it "redirects to sign-in path if not logged in" do
      session[:user_id] = nil
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end
  describe 'POST search' do
    it "sets the search term variable" do
      che = Fabricate(:video, title: 'Che')
      post :search, search_term: 'Che'
      expect(assigns(:search_term)).to eq "Che"
    end
    it "returns videos for authenticated users" do
      che = Fabricate(:video, title: 'Che')
      post :search, search_term: 'Che'
      expect(assigns(:videos)).to eq([che])
    end
    it "redirects to sign_in path if not logged in" do
      session[:user_id] = nil
      che = Fabricate(:video, title: 'Che')
      post :search, search_term: 'Che'
      expect(response).to redirect_to sign_in_path      
    end
  end
end