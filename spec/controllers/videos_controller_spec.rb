require 'spec_helper'

describe VideosController do
  describe 'GET #show' do
    it 'sets the @video variable when a video is found using the provided id for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video
      expect(assigns(:video)).to eq(video)
    end

    it 'redirects to the sign in page for unauthorized users' do
      video = Fabricate(:video)
      get :show, id: video
      expect(response).to redirect_to sign_in_path
    end

    it 'sets @review' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video
      expect(assigns(:review)).to be_instance_of(Review)
    end
  end

  describe 'POST #search' do
    it 'sets @videos to an array of the matching videos for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video, title: 'Sons of anarchy')
      post :search, search_string: 'anarchy'
      expect(assigns(:videos)).to eq([video])
    end

    it 'redirects unauthorized users to the sign in page' do
      Fabricate(:video, title: 'Sons of anarchy')
      post :search, search_string: 'anarchy'
      expect(response).to redirect_to sign_in_path
    end
  end
end
