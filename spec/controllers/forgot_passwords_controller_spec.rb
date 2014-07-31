require 'rails_helper'

describe ForgotPasswordsController do
  describe 'POST create' do
    # add blank
    context 'email is valid' do
      it 'should redirect to the confirm password reset page' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: 'user@example.com'
        expect(response).to redirect_to confirm_password_reset_path
      end
      it 'should assign @user by email' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        expect(assigns(:user)).to eq(user)
      end
      it 'should create a new password reset token' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        expect(UserToken.first).to_not be_blank
      end
      it 'should associate the token with the user' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        expect(UserToken.first.user).to eq(user)
      end
      it 'should deliver an email to user' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        mail = ActionMailer::Base.deliveries
        expect(mail).to_not be_empty
      end
      it 'should deliver to the correct recipient' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq([user.email])
      end
      it 'should contain a link to the reset password page' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        mail = ActionMailer::Base.deliveries.last
        expect(mail.body).to include('reset password')
      end
      it 'should contain a link with the reset token' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        token = UserToken.first.token
        mail = ActionMailer::Base.deliveries.last
        expect(mail.body).to include(token)
      end
    end
    context 'input is blank' do
      it 'redirects to forgot password page' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
    end
    context 'email is not valid' do
      it 'should flash message if email is not valid' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: 'other@example.com'
        expect(flash[:danger]).to eq('Email invalid')
      end

      it 'should redirect to forgot password page' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: 'other@example.com'
        expect(response).to redirect_to forgot_password_path
      end
    end
  end
end
