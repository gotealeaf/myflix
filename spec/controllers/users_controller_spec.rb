require 'spec_helper'
require 'pry'

describe UsersController do
  describe 'GET #new' do
    it 'sets up new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'redirects the user if they are logged in already'
  end
  describe "POST #create" do
    it 'sets up the @user with the user_params'
    context 'attempts to save @user' do
      it 'sets the session[user_id] if sucessfully saved'
      it 'redirects the user if save was successful'
      it 'renders #new if the save was not successful'
    end
  end
end
