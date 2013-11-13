require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
  end
  
  describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      
      video1 = Fabricate(:video, name: "Joe")
      
      post :search, search: 'Joe'
      expect(assigns(:results)).to eq([video1])
    end
  end
end