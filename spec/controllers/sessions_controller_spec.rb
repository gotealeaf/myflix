require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    it 'should render new template for unauthenticated users'do
      get :new
      expect(response).to render_template(:new)
    end
    it 'should redirect to home page for authenticated users' do
      session[:username] = Fabricate(:user).username
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    context 'if authentication passes' do
      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end
      it 'assigns username to session[:username]' do
        expect(session[:username]).to eq(@user.username)
      end
      it 'flashes a welcome message' do
        expect(flash[:success]).to eq("Welcome #{ @user.username }")
      end
      it 'redirects to the home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'if authentication fails' do
      before do
        post :create
      end
      it 'flashes an error message' do
        expect(flash[:danger]).not_to be_blank
      end
      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET destroy' do
    context 'when user logs out' do
      before do
        session[:username] = Fabricate(:user).username
        get :destroy
      end
      it 'should assign nil to session[:username]' do
        expect(session[:username]).to eq(nil)
      end
      it 'should flash a success message' do
        expect(flash[:success]).not_to be_blank
      end
      it 'should redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
