require 'spec_helper'
require 'pry'

describe SessionsController do
  describe 'GET #new' do
    it 'creates new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  # describe 'POST #create' do
  #   it 'sets @user object correctly'
  #   post :create, user: Fabricate.attributes_for(:user)

  # end

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
