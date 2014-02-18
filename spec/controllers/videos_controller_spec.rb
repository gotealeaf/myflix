require 'spec_helper'
require 'pry'

describe VideosController do
  describe 'GET #show' do
    before(:each) do
      @simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
      @futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      @future = Video.create(title: "Future", description: "This is the future.")
      session[:user_id] = Fabricate(:user).id
    end

    it 'sets the @video correctly' do
      get :show, id: @futurama.id
      expect(assigns(:video)).to eq @futurama
    end

    it 'renders the :show template' do
      get :show, id: @futurama.id
      expect(response).to render_template :show
    end

    it 'redirects unauthenticated user to sign in page' do
      session[:user_id] = nil
      get :show, id: @futurama.id
      expect(response).to redirect_to login_path
    end
  end

  describe 'POST #search' do
    before(:each) do
      @simpsons = Fabricate(:video, title: "Simpsons")
      @futurama = Fabricate(:video, title: "Futurama")
      @future = Fabricate(:video, title: "Future")
      session[:user_id] = Fabricate(:user).id
      request.env["HTTP_REFERER"] = home_path
    end

    it 'sets the @videos object correctly' do
      session[:user_id] = '1'
      post :search, q: 'futur'
      expect(assigns(:videos)).to match_array([@future, @futurama])
    end

    it 'if no results return empty array' do
      post :search, q: 'ttyl4499'
      expect(assigns(:videos)).to match_array([])
    end

    it 'redirects :back if no results are returned.' do
      post :search, q: 'ttyl4499'
      expect(response).to redirect_to(home_path)
    end

    it 'renders the :index template if results are found' do
      post :search, q: 'futur'
      expect(response).to render_template(:search)
    end

    it 'redirects user to login_path if unauthenticated' do
      session[:user_id] = nil
      post :search, q: 'futur'
      expect(response).to redirect_to login_path
    end
  end
end
