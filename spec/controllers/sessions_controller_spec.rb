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
      let(:bob) { bob = Fabricate(:user) }
      before do
        post :create, user: { email: bob.email, password: bob.password }
      end
      it 'creates a new session for the signed in user' do
        expect(session[:user_id]).to eq(bob.id) 
      end
      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end
      it 'sets the notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      let(:bob) { bob = Fabricate(:user) }
      before do
        post :create, user: { email: bob.email, password: '?' }
      end
      it 'does not create a new session' do
        expect(session[:user_id]).to be_nil 
      end
      it 'redirects user to the sign in page' do
        expect(response).to redirect_to sign_in_path
      end
      it 'sets the error message' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it 'sets session to nil' do
      expect(session[:user_id]).to be_nil  
    end
    it 'redirects user to root path' do
      expect(response).to redirect_to root_path
    end
    it 'sets the notice message' do
      expect(flash[:notice]).not_to be_blank
    end
  end

end
