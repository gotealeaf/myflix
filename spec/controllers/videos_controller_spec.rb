require 'rails_helper'

describe VideosController do
  describe 'GET show' do
    context 'when users are authenticated' do

      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        session[:username] = user.username
      end

      it 'sets the @video variable' do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it 'sets the @reviews variable' do
        review_1 = Fabricate(:review, video: video, user: user)
        review_2 = Fabricate(:review, video: video, user: user)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review_1, review_2])
      end
    end

    context 'when users are unauthenticated'
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
