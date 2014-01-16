require 'spec_helper'

describe VideosController do
  
  describe 'GET show' do
    it 'sets @video for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it 'sets @reviews for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, user_id: session[:user_id])
      review2 = Fabricate(:review, video: video, user_id: session[:user_id])
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array ([review1, review2])
    end
    it 'redirects unthenticated users to sign in page' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe 'POST search' do
    it 'redirects unthenticated users to sign in page' do
      seven = Fabricate(:video, title: 'Seven')
      post :search, search_term: 'seven'
      expect(response).to redirect_to sign_in_path
    end
    it 'sets @results for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      moon = Fabricate(:video, title: 'Moon')
      no = Fabricate(:video, title: 'No')
      post :search, search_term: 'o'
      expect(assigns(:results)).to eq([no, moon])
    end
  end
end
