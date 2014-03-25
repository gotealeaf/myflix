require 'spec_helper'

describe VideosController do
  describe "GET #show" do 
    let (:video) { Fabricate(:video) }  
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video
      expect(assigns(:video)).to eq video
    end
    it "sets the @review variable for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      get :show, id: video
      expect(assigns(:review)).to be_new_record
      expect(assigns(:review)).to be_instance_of(Review)
    end
    it "redirects to the root path for unauthenticated users" do
      get :show, id: video
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #search" do
    let (:video) { Fabricate(:video) }  
    it "sets the @videos variable for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      get :search, search_term: video.title
      expect(assigns(:videos)).to include(video)
    end
    let (:video) { Fabricate(:video) }      
    it "redirects to root path with unathenticated user" do
      get :search, search_term: video.title
      expect(response).to redirect_to root_path
    end
  end
end