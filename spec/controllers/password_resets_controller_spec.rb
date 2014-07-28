require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do
    it 'assigns @user variable' do
      password_reset = Fabricate(:password_reset, user: user)
      get :show, id: password_reset.token
      expect(assigns(:user)).to eq(user)
    end
    it 'redirects to reset password page' do
      password_reset = Fabricate(:password_reset, user: user)
      get :show, id: password_reset.token
      expect(response).to redirect_to reset_password_path
    end
  end

  describe 'POST create' do
    it 'assigns @user variable with valid user' do
      user = Fabricate(:user)
      session[:id] = user.id
      post :create, id: 1
      expect(assigns(:user)).to eq(user)
    end
    context 'if new password is valid' do

      before { session[:id] = user.id }

      it 'saves the new password if valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'drowssap' }
        expect(User.first.authenticate('drowssap')).to eq(user)
      end
      it 'sets session[:id] to nil' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'drowssap' }
        expect(session[:id]).to be_nil
      end
      it 'should delete user associated row from password_resets table' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'drowssap' }
        expect(PasswordReset.count).to eq(0)
      end
      it 'flashes a success message' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'drowssap' }
        expect(flash[:success]).to eq('Your password has been reset!')
      end
      it 'redirects to sign in page' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'drowssap' }
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'if new password is not valid' do

      before { session[:id] = user.id }

      it 'redirects to reset password page if new password not valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'password' }
        expect(response).to redirect_to reset_password_path
      end
      it 'flashes a message if new password is not valid' do
        password_reset = Fabricate(:password_reset, user: user)
        post :create, { password: 'drowssap', password_confirmation: 'password' }
        expect(flash[:danger]).to include('please try again.')
      end
    end
  end
end
