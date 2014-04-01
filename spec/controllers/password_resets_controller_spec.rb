require 'spec_helper'
require 'pry'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe PasswordResetsController do
  describe 'POST #new' do
    context 'with a valid user' do
      let(:adam) { Fabricate(:user) }

      before do
        post :create, user: {email: adam.email}
      end

      context 'email validation' do
        it 'sends the correct user an email' do
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([adam.email])
        end

        it 'send the correct email to the user'
      end

      it 'generates creates a reset token on the user' do
        expect(adam.reload.reset_token).to_not be_nil
      end
      it 'redirects the user to a confirmation page' do
        expect(response).to redirect_to reset_request_confirmation_path
      end
    end
    it 'does not send email to a non-existing address' do
      adam = Fabricate(:user)
      post :create, user: {email: adam.email}
      post :create, user: {email: "this@gmail.com"}
      message = ActionMailer::Base.deliveries.last
      expect(message.to).to_not eq(["this@gmail.com"])
    end
  end
  describe 'GET #edit' do
    let(:reset_string) { SecureRandom.urlsafe_base64 }
    let(:adam) { Fabricate(:user, reset_token: reset_string) }
    it 'sets the user object based on token in URL' do
      get :edit, id: adam.reset_token
      expect(assigns(:user)).to eq(adam)
    end
  end
end
