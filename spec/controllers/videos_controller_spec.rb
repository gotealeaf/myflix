require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    it 'sets the @video variable for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it 'redirects the user to the sign_in_path for unauthenticated users' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST search' do
    it 'sets @video_array variable for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      family_guy = Fabricate(:video, title: 'Family Guy')
      post :search, search_term: 'fam'
      expect(assigns(:video_array)).to eq([family_guy])
    end
    it 'redirects the user to the sign_in_path for unauthenticated users' do
      family_guy = Fabricate(:video, title: 'Family Guy')
      post :search, search_term: 'fam'
      expect(response).to redirect_to root_path
    end
  end
end