require 'spec_helper'

describe VideosController do


  let(:user)  { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  describe "videos#show" do
    it "assigns specific video to video by id when logon" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(assigns(:video)).to eq video
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end  

  describe "videos#search" do
    it "assigns specific videos to @videos by search_item" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_item: video.title 
      expect(assigns(:videos)).to eq [video]
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :search, search_item: video.title 
      expect(response).to redirect_to root_path
    end 
  end


end
