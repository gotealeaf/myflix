require 'spec_helper'

describe SessionsController do

  describe 'GET new' do
    it 'renders new template for unauthenticated user' do
      get :new
      expect(response).to render_template :new
    end
    it 'redirects authenticated user to home page' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      before do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
      end
      it 'creates a new session for the signed in user' do
        expect(session[:user_id]).to eq(bob.id) 
      end
      it 'redirects to the home page'
    end

    context 'with invalid credentials' do

    end
  end

  describe 'GET destroy' do

  end

end
