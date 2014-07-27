require 'rails_helper'

describe ForgotPasswordsController do
  describe 'GET new' do
    it 'should render the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
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
        expect(PasswordReset.first).to_not be_blank
      end
      it 'should associate the token with the user' do
        user = Fabricate(:user, email: 'user@example.com')
        post :create, email: user.email
        expect(PasswordReset.first.user).to eq(user)
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
        token = PasswordReset.first.token
        mail = ActionMailer::Base.deliveries.last
        expect(mail.body).to include(token)
      end
    end

    context 'email is not valid' do
      it 'should flash message if email is not valid'
      it 'should redirect to forgot password page'
    end
  end
end
