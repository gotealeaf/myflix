require 'spec_helper'

describe VideosController do
  describe 'GET #show' do
    it 'sets the @video variable when a video is found using the provided id' do
      video = Video.create(title: 'Dexter', description: 'Serial killer')
      get :show, id: video
      assigns(:video).should eq(video)
    end

    it 'renders the show template when a video is found using the provided id' do
      video = Video.create(title: 'Dexter', description: 'Serial killer')
      get :show, id: video
      response.should render_template :show
    end
  end

  describe 'POST #search' do
    it 'returns an empty array if no videos match the provided search string' do
      Video.create(title: 'Dexter', description: 'Serial killer')
      post :search, search_string: 'u'
      assigns(:videos).should eq([])
    end

    it 'returns all videos found using the provided search string case-insensitively' do
      dexter = Video.create(title: 'Dexter', description: 'Serial killer')
      bones = Video.create(title: 'Bones', description: 'Some people do some stuff')
      sons_of_anarchy = Video.create(title: 'Sons of Anarchy', description: 'Motorcycle gang')
      post :search, search_string: 'E'
      assigns(:videos).should match_array([dexter, bones])
    end
  end
end
