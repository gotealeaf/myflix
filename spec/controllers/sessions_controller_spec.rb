require 'spec_helper'

describe SessionsController do
  describe 'GET #new' do
    it 'redirects to home_path if user is already authorized' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to(home_path)
    end
  end

  describe 'POST #create' do
    let(:adam) { Fabricate(:user) }

    context 'with valid credentials' do
      before { post :create, email: adam.email, password: adam.password }

      it 'sets user_id session variable' do
        expect(session[:user_id]).to eq(adam.id)
      end

      it 'redirects to home_path' do
        expect(response).to redirect_to(home_path)
      end

      it 'shows a success message' do
        expect(flash[:success]).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      before { post :create, email: adam.email, password: adam.password + 'wrong' }

      it 'should not set user in session' do
        expect(session[:user_id]).to be_nil
      end

      it 'renders #new template' do
        expect(response).to render_template :new
      end

      it 'displays error message' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'GET #destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it 'sets session user_id variable to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root_path' do
      expect(response).to redirect_to(root_path)
    end

    it 'sets success message' do
      expect(flash[:info]).not_to be_blank
    end
  end
end
