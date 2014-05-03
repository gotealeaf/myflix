require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    context "with invalid password token" do
      before do 
        Fabricate(:user)
        get :show, id: 'random'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with valid password token" do
      let(:susan) { Fabricate(:user) }

      before do
        susan.generate_password_token
        get :show, id: susan.password_token
      end

      it "renders the password reset page if the password token matches a user" do
        expect(response).to render_template :show
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq susan
      end

      it "does not remove the user's password token" do
        expect(susan.reload.password_token).to_not be_blank
      end
    end
  end
  
  describe "POST update_password" do
    context "with invalid password token" do
      before do 
        Fabricate(:user)
        post :update_password, password_token: 'random', password: 'password', password_confirmation: 'password'
      end

      it "redirects to the expired token page" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with valid password token" do
      let(:suzy) { Fabricate(:user) }

      before do
        suzy.generate_password_token
        post :update_password, password_token: suzy.password_token, password: 'password2', password_confirmation: 'password2'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets success message" do
        expect(flash[:success]).to_not be_blank
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq suzy
      end

      it "updates the user's password" do
        expect(suzy.reload.authenticate('password2')).to be_true
      end

      it "removes the user's password token" do
        expect(suzy.reload.password_token).to be_blank
      end
    end

    context "with passwords that do no match" do
      let(:johnny) { Fabricate(:user) }

      before do
        johnny.generate_password_token
        post :update_password, password_token: johnny.password_token, password: 'pass1', password_confirmation: 'pass2'
      end

      it "redirects to the show reset password page" do
        expect(response).to redirect_to password_reset_path(johnny.password_token)
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end
    end
  end
end