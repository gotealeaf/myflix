require 'spec_helper'

describe VideosController do
  before { set_current_user }
  describe 'GET index' do
    it "builds a Categories collection" do
      biographies = Fabricate(:category, name: "Biographies")
      romantic_dramas = Fabricate(:category, name: "Romantic Dramas")
      get :index
      expect(assigns(:categories).first).to eq biographies
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
  end
  describe 'GET show' do
    it "finds a video for authenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it_behaves_like "require sign in" do
      let(:action) { video = Fabricate(:video); get :show, id: video.id }
    end
  end
  describe 'POST search' do
    it "sets the search term variable" do
      che = Fabricate(:video, title: 'Che')
      post :search, search_term: 'Che'
      expect(assigns(:search_term)).to eq "Che"
    end
    it "returns videos for authenticated users" do
      che = Fabricate(:video, title: 'Che')
      post :search, search_term: 'Che'
      expect(assigns(:videos)).to eq([che])
    end
    it_behaves_like "require sign in" do
      let(:action) { che = Fabricate(:video, title: 'Che'); post :search, search_term: 'Che' }
    end
  end
end