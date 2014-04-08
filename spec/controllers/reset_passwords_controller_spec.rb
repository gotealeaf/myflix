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
    context "with valid input"
    it "redirects user to the sign in path" do
      bob = Fabricate(:user, password: "password")
      
      post :create, token: bob.token, password: "abcdefg"
      expect(response).to redirect_to(sign_in_path)
    end

    it "changes the password of the user" do
      bob = Fabricate(:user, password: "password")
      post :create, token: bob.token, password: "abcdefg"
      expect(bob.reload.authenticate('abcdefg')).to be_true
    end
    it "resets user's token"
    context "with invalid input"
  end

end