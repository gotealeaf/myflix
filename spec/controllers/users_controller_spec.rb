require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'creates a new @user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'if validation passes' do
      before do
        post :create, user: { username: 'dhartoto', full_name: 'Dito Hartoto',
                              email: 'dhartoto@yahoo.com', password: 'password',
                              password_confirmation: 'password'}
      end
      it 'creates a new user' do
        expect(User.all.count).to eq(1)
      end
      it 'Flash a welcome message' do
        expect(flash[:success]).to eq("Welcome Dito Hartoto!")
      end
      it 'assigns session[:user]' do
        expect(session[:username]).to eq('dhartoto')
      end
      it 'redirects to video_path' do
        expect(response).to redirect_to videos_path
      end
    end

    context 'if validation fails' do
      before do
        post :create, user: { username: 'dhartoto' }
      end

      it 'does not create a user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
      it 'creates a new @user object' do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
end
