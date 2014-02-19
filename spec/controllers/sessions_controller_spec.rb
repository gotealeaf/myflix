require 'spec_helper'
require 'pry'

describe SessionsController do
  describe 'GET #new' do
    it 'creates new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  describe 'POST #create' do
    before(:each) do
      @adam_params = Fabricate.attributes_for(:user)
      @adam = User.create(@adam_params)
    end
    it 'sets @user object correctly' do
      post :create, user: @adam_params
      expect(assigns(:user).email).to eq(@adam_params[:email])
    end
    it 'returns user object is authentication passes' do
      post :create, user: @adam_params
      obj = assigns(:user).authenticate(@adam_params[:password])
      expect(obj).to eq(@adam)
    end
    it 'returns false if authentication fails' do
      post :create, user: @adam_params
      obj = assigns(:user).authenticate(Faker::Lorem.characters(char_count = 8))
      expect(obj).to eq(false)
    end
    it 'sets the session[:user_id] to the user.id' do
      post :create, user: @adam_params
      expect(session[:user_id]).to eq(2)
    end
    it 'displays flash[:success] if authentication is sucessful'
    it 'redirect_to home_path if authentication is complete'
    it 'displays flash[:danger] if authentication fails'
    it 'renders new template if authentication fails'
  end

  describe 'GET #logout' do
    it 'sets user_id to nil' do
      session[:user_id] = 1
      get :logout
      expect(session[:user_id]).to eq(nil)
    end
    it 'redirect_to root_path' do
      get :logout
      expect(response).to redirect_to root_path
    end
  end
end
