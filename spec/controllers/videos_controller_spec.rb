require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    let(:video) { Fabricate(:video) }

    it 'sets the @video variable for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it 'sets the @reviews variable for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
    it 'redirects the user to the sign_in_path for unauthenticated users' do
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST search' do
    let(:family_guy) { Fabricate(:video, title: 'Family Guy') }

    it 'sets @video_array variable for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      post :search, search_term: 'fam'
      expect(assigns(:video_array)).to eq([family_guy])
    end
    it 'redirects the user to the sign_in_path for unauthenticated users' do
      post :search, search_term: 'fam'
      expect(response).to redirect_to root_path
    end
  end
end