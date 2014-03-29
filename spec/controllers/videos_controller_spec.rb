require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    it "sets the @video for authenticated users" do
      video = Fabricate(:video)
      session[:user_id] = Fabricate(:user)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it "set @reviews for authenticated users" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      session[:user_id] = Fabricate(:user)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
    it "redirects to login path for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe 'GET search' do
    it "sets @videos for authenticated users" do
      video = Fabricate(:video, title: 'video1')
      session[:user_id] = Fabricate(:user)
      get :search, search_term: 'ide'
      expect(assigns(:videos)).to eq([video])
    end
    it "redirects to login path for unauthenticated users" do
      video = Fabricate(:video)
      get :search, search_term: 'ide'
      expect(response).to redirect_to login_path
    end
  end
end
