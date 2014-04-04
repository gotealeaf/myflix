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

      context 'valid email' do
        it 'sends the correct user an email' do
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([adam.email])
        end
        it 'generates creates a reset token on the user' do
          expect(adam.reload.reset_token).to_not be_nil
        end
        it 'redirects the user to a confirmation page' do
          expect(response).to redirect_to reset_request_confirmation_path
        end
      end
    end
    it 'does not send email to a non-existing address' do
      adam = Fabricate(:user)
      post :create, user: { email: adam.email }
      post :create, user: { email: "this@gmail.com" }
      message = ActionMailer::Base.deliveries.last
      expect(message.to).to_not eq(["this@gmail.com"])
    end
    context 'blank email submitted' do
      it 'redirects user to the reset_password page' do
        post :create, user: { email: "" }
        expect(response).to redirect_to reset_password_path
      end
      it 'displays a danger msg' do
        post :create, user: { email: "" }
        expect(flash[:danger]).to be_present
      end
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

  describe 'PATCH #update' do
    let(:adam) { Fabricate(:user, reset_token: SecureRandom.urlsafe_base64) }
    it 'set the user object to the correct user' do
      patch :update, { token: adam.reset_token, user: { password: "test" } }
      expect(assigns(:user).fullname).to eq(adam.fullname)
    end
    context "blank password is submitted" do
      it 'doesnt save a users password' do
        new_password = ""
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(User.first.authenticate(new_password)).to eq(false)
      end
      it 'has flash message' do
        new_password = ""
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(flash[:danger]).to be_present
      end
      it 'renders update template' do
        new_password = ""
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(response).to render_template "edit"
      end
    end
    context 'with valid password' do
      it 'updates the password to the new password for the user' do
        new_password = "test"
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(User.first.authenticate(new_password)).to eq(adam)
      end
      it 'shows a flash message to the user' do
        new_password = "test"
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(flash[:success]).to be_present
      end
      it 'redirects the user the the login page' do
        new_password = "test"
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(response).to redirect_to login_path
      end
      it 'sets the user token to nil' do
        new_password = "test"
        patch :update, { token: adam.reset_token, user: { password: new_password } }
        assigns
        expect(User.first.reset_token).to eq(nil)
      end
    end
  end
end
