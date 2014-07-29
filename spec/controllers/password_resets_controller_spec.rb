require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do
    context 'when token is valid' do
      it 'assigns @user variable' do
        password_reset = Fabricate(:password_reset, user: user)
        get :show, id: password_reset.token
        expect(assigns(:user)).to eq(user)
      end
      it 'assigns @token variable' do
        password_reset = Fabricate(:password_reset, user: user)
        get :show, id: password_reset.token
        expect(assigns(:token)).to eq(user.password_reset.token)
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
    it 'assigns @user variable with valid user' do
      password_reset = Fabricate(:password_reset, user: user)
      post :create, token: password_reset.token
      expect(assigns(:user)).to eq(user)
    end
    context 'if new password is valid' do
      it 'saves the new password if valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(User.first.authenticate('drowssap')).to eq(user)
      end
      it 'should delete user associated row from password_resets table' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(PasswordReset.count).to eq(0)
      end
      it 'flashes a success message' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(flash[:success]).to eq('Your password has been reset!')
      end
      it 'redirects to sign in page' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'drowssap' }
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'if new password is not valid' do
      it 'redirects to reset password page if new password not valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'password' }
        expect(response).to redirect_to reset_password_path
      end
      it 'flashes a message if new password is not valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { token: password_reset.token, password: 'drowssap', password_confirmation: 'password' }
        expect(flash[:danger]).to include('please try again.')
      end
    end
  end
end
