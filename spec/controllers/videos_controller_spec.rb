require 'spec_helper'

describe VideosController do
  before do
    my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
    session[:user_id] = my_user.id
  end
  describe 'GET index' do
    it "builds a Categories collection" do
      romantic_dramas = Category.create(name: "Romantic Dramas")
      biographies = Category.create(name: "Biographies")
      get :index
      expect(assigns(:categories).first).to eq biographies
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
    it "redirects to root if not logged in" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to root_path
    end
  end
  describe 'GET show' do
    it "finds a video" do
      video = Video.create(title: "Che", description: "great video")
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    it "renders the show template" do
      video = Video.create(title: "Che", description: "great video")
      get :show, id: video.id
      expect(response).to render_template :show
    end
    it "redirects to root if not logged in" do
      session[:user_id] = nil
      video = Video.create(title: "Che", description: "great video")
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end
  describe 'POST search' do
    it "sets the search term variable" do
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(assigns(:search_term)).to eq "Che"
    end
    it "returns videos" do
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(assigns(:videos)).to eq([video])
    end
    it "renders search" do
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(response).to render_template :search
    end
    it "redirects to root if not logged in" do
      session[:user_id] = nil
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(response).to redirect_to root_path
    end
  end
end