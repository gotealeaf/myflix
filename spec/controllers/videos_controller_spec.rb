require 'spec_helper'

describe VideosController do

  describe "videos#show" do
    before(:each) do
      @video = Fabricate(:video)
    end
    it "assigns specific video to @video by id when logon" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: @video.id
      expect(assigns(:video)).to eq @video
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :show, id: @video.id
      expect(response).to redirect_to root_path
    end
  end  

  describe "videos#search" do
    before(:each)  do
      @videos = Fabricate(:video)
    end
    it "assigns specific videos to @videos by search_item" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_item: @videos.title 
      expect(assigns(:videos)).to eq [@videos]
    end
    it "redirects to root when not logging in" do
      session[:user_id] = nil
      get :search, search_item: @videos.title 
      expect(response).to redirect_to root_path
    end 
  end

end
