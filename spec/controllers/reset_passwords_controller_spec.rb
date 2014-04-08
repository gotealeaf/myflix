require 'spec_helper'

describe ResetPasswordsController do
  describe "GET show" do
    it "renders page for submitting a new password" do
      bob = Fabricate(:user)
      #bob.update_columns(token: bob.generate_token)
      get :show, id: bob.token
      expect(response).to render_template('reset_passwords/show')
    end

    it "sets @token" do
      bob = Fabricate(:user)
      #bob.update_columns(token: bob.generate_token)
      get :show, id: bob.token
      expect(assigns(:token)).to eq(bob.token)
    end

    it "renders invalid token page when token has expired" do
      bob = Fabricate(:user)
      get :show, id: '12345'
      expect(response).to redirect_to(expired_token_path)
    end
  end

  describe "POST create" do
    context "with valid input" do

      it "changes the password of the user" do
        bob = Fabricate(:user, password: "password")
        post :create, token: bob.token, password: "new_password"
        
        expect(bob.reload.authenticate('new_password')).to eq(bob)
      end

      it "resets user's token" do
        bob = Fabricate(:user, password: "password")
        token = bob.token
        post :create, token: token, password: "new_password"
        expect(bob.reload.token).not_to eq(token)
      end

      it "sets a notice, requesting the user to sign in with the new password" do
        bob = Fabricate(:user, password: "password")
        post :create, token: bob.token, password: "new_password"
        
        expect(flash[:notice]).to eq("Please go to the log in page and sign in with your new password.")
      end
    end
    context "with invalid input" do
      it "redirects to exipred token page" do
        bob = Fabricate(:user, password: "password")
        post :create, token: "12345", password: "new_password"

        expect(response).to redirect_to(expired_token_path)
      end
    end
  end

end