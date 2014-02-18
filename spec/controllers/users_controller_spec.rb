require 'spec_helper'
require 'pry'

describe UsersController do
  describe 'GET #new' do
    it 'sets up new user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'redirects the user if they are logged in already' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST #create" do
    before(:each) do
      @user_sample_params = Fabricate.attributes_for(:user)
    end
    it 'sets up the @user with the user_params' do
      post :create, user: @user_sample_params
      user = User.find_by(email: @user_sample_params[:email])
      expect(user.authenticate(@user_sample_params[:password])).to be_instance_of(User)
    end
    it 'it fails to save if params incorrect' do
      post :create, user: Fabricate.attributes_for(:user, fullname: nil)
      expect(User.count).to eq(0)
    end
    it 'sets the session[user_id] if sucessfully saved' do
      post :create, user: @user_sample_params
      user = User.first
      expect(session[:user_id]).to eq(user.id)
    end
    it 'renders #new if the save was not successful' do
      post :create, user: Fabricate.attributes_for(:user, fullname: nil)
      expect(response).to render_template :new
    end
    it 'redirects the user if the save was sucessful' do
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to redirect_to home_path
    end
  end
end
