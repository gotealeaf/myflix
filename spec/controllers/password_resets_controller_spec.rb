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
        get :show, id: susan.token
      end

      it "renders the password reset page if the password token matches a user" do
        expect(response).to render_template :show
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq susan
      end

      it "does not remove the user's password token" do
        expect(susan.reload.token).to_not be_blank
      end
    end
  end
  
  describe "POST create" do
    context "with invalid password token" do
      before do 
        Fabricate(:user)
        post :create, token: 'random', password: 'password', password_confirmation: 'password'
      end

      it "redirects to the expired token page" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with valid password token" do
      let(:suzy) { Fabricate(:user) }

      before do
        post :create, token: suzy.token, password: 'password2', password_confirmation: 'password2'
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

      it "updates the user's token" do
        expect(suzy.token).to_not eq suzy.reload.token
      end
    end

    context "with passwords that do no match" do
      let(:johnny) { Fabricate(:user) }

      before do
        post :create, token: johnny.token, password: 'pass1', password_confirmation: 'pass2'
      end

      it "redirects to the show reset password page" do
        expect(response).to redirect_to password_reset_path(johnny.token)
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end
    end
  end
end