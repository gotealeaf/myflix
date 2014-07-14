require 'rails_helper'

describe VideosController do
  describe 'GET show' do
    context 'when users are authenticated' do

      before { set_session_user }

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

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :show, id: video.id }
    end
  end

  describe 'POST search' do
    it 'sets the @results variable for authenticated user' do
      set_session_user
      gladiator = Fabricate(:video, name: 'gladiator')
      get :search, search_name: 'diator'
      expect(assigns(:results)).to eq([gladiator])
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :search, search_name: 'diator' }
    end
  end
end
