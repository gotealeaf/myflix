require 'spec_helper'

describe VideosController do
  describe 'GET #show' do
    it 'sets the @video variable when a video is found using the provided id for authenticated users' do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video
      expect(assigns(:video)).to eq(video)
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) do
        video = Fabricate(:video)
        get :show, id: video
      end
    end

    it 'sets @review' do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video
      expect(assigns(:review)).to be_instance_of(Review)
    end

    it 'creates an empty review' do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video
      expect(assigns(:review)).to be_new_record
    end
  end

  describe 'POST #search' do
    it 'sets @videos to an array of the matching videos for authenticated users' do
      set_current_user
      video = Fabricate(:video, title: 'Sons of anarchy')
      post :search, search_string: 'anarchy'
      expect(assigns(:videos)).to eq([video])
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :search, search_string: 'anarchy' }
    end
  end
end
