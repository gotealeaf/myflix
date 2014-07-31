require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do

    let(:user_token) { Fabricate(:user_token, user: user) }

    context 'when token is valid' do
      it 'assigns @user variable' do
        get :show, id: user_token.token
        expect(assigns(:user)).to eq(user)
      end
      it 'assigns @token variable' do
        get :show, id: user_token.token
        expect(assigns(:token)).to eq(user.user_tokens.first.token)
      end
    end

    context 'when token is invalid' do
      it 'redirects to the invalid token page' do
        get :show, id: SecureRandom.urlsafe_base64
        expect(response).to redirect_to invalid_token_path
      end
    end
  end

  describe 'POST create' do

    let(:user_token) { Fabricate(:user_token, user: user) }

    it 'assigns @user variable with valid user' do
      post :create, token: user_token.token
      expect(assigns(:user)).to eq(user)
    end
    context 'if new password is valid' do
      it 'saves the new password if valid' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(User.first.authenticate('drowssap')).to eq(user)
      end
      it 'should delete user associated row from password_resets table' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(UserToken.count).to eq(0)
      end
      it 'flashes a success message' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(flash[:success]).to eq('Your password has been reset!')
      end
      it 'redirects to sign in page' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'if new password is not valid' do

      let(:user_token) { Fabricate(:user_token, user: user) }

      it 'redirects to reset password page if new password not valid' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'password' }
        expect(response).to redirect_to reset_password_path
      end
      it 'flashes a message if new password is not valid' do
        post :create, { token: user_token.token, password: 'drowssap', password_confirmation: 'password' }
        expect(flash[:danger]).to include('please try again.')
      end
    end
  end
end
