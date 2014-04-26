require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "blank input" do
      it "flash error should appear" do
        post :create
        expect(flash[:error]).to be_present
      end

      it "redirects to forgot password page" do
        post :create
        expect(response).to redirect_to forgot_password_path
      end
    end

    context "existing email" do
      before do
        Fabricate(:user, email: "alice@example.com")
        post :create, email: "alice@example.com"
      end

      it "should redirect to the forgot password confirmation page" do
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "emails the user reset information" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@example.com"])
      end
    end

    context "non-existing email" do
      before do
        post :create, email: "fakeemail@example.com"
      end

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "flash error should appear" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET show" do
    it "renders show template if the token is valid" do
      alice = Fabricate(:user, token: '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "sets @token" do
      alice = Fabricate(:user, token: '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to the expired token page if the token is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST reset" do
    context "with valid token" do
      it "redirects to the sign in page" do
        alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        post :reset, token: '12345', password: 'new_password', password_confirmation: 'new_password'
        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        post :reset, token: '12345', password: 'new_password', password_confirmation: 'new_password'
        expect(alice.reload.authenticate('new_password')).to be_true
      end

      it "sets the flash success message" do
        alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        post :reset, token: '12345', password: 'new_password', password_confirmation: 'new_password'
        expect(flash[:success]).to be_present
      end

      it "removes the user's token" do
        alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        post :reset, token: '12345', password: 'new_password', password_confirmation: 'new_password'
        expect(alice.reload.token).to be_nil
      end

      context "invalid password inputs" do
        before do
          request.env["HTTP_REFERER"] = password_reset_path('12345')
        end

        it "redirects to same page when passwords dont match" do
          alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
          post :reset, token: '12345', password: 'new_password', password_confirmation: 'wrong_password'
          expect(response).to redirect_to password_reset_path('12345')
        end

        it "redirects to same page when passwords are less than 6 chars" do
          alice = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
          post :reset, token: '12345', password: 'short', password_confirmation: 'short'
          expect(response).to redirect_to password_reset_path('12345')
        end
      end
    end

    context "with invalid token" do
      it "redirects to the expired token path" do
        post :reset, token: 'badtoken', password: 'aPassword', password_confirmation: 'aPassword'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end