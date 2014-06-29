require 'rails_helper'

describe VideosController do
  describe 'GET show' do
    it 'sets the @video variable for auth user' do
      session[:username] = Fabricate(:user).username
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it 'redirects unauthenticated user to the sign in page' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'POST search' do
    it 'sets the @results variable for authenticated user' do
      session[:username] = Fabricate(:user).username
      gladiator = Fabricate(:video, name: 'gladiator')
      get :search, search_name: 'diator'
      expect(assigns(:results)).to eq([gladiator])
    end

    it 'redirects aunauthenticated user to the sign in page' do
      get :search, search_name: 'diator'
      expect(response).to redirect_to sign_in_path
    end
  end
end
