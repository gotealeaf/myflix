require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    context "submitted id matches a user token" do
      it "sets the user" do
        alice = Fabricate(:user)
        get :show, id: alice.token
        expect(assigns(:user)).to eq(alice)
      end

      it "renders the show template" do
        alice = Fabricate(:user)
        get :show, id: alice.token
        expect(response).to render_template :show
      end
    end

    context "submitted id does not match a user token" do
      it "redirects to the invalid token path" do
        get :show, id: ""
        expect(response).to redirect_to expired_token_path
      end
    end
  end

  describe "POST create" do
    context "user id and token match a user in the database" do
      it "changes the user's password" do
        alice = Fabricate(:user)
        post :create, user_token: alice.token, password: "new_password"
        expect(alice.reload.authenticate("new_password")).to eq(alice)
      end

      it "changes the user's token to a new one" do
        alice = Fabricate(:user)
        prior_token = alice.token
        post :create, user_token: alice.token, password: "new_password"
        expect(alice.reload.token).not_to eq(prior_token)
      end

      it "sets a success message" do
        alice = Fabricate(:user)
        prior_token = alice.token
        post :create, user_token: alice.token, password: "new_password"
        expect(flash[:success]).to eq("You reset your password. Please log in.")
      end

      it "redirects to the login page" do
        alice = Fabricate(:user)
        prior_token = alice.token
        post :create, user_token: alice.token, password: "new_password"
        expect(response).to redirect_to login_path
      end
    end

    context "user id and token do not match a user in the database" do
      it "does not change the user's password" do
        alice = Fabricate(:user)
        post :create, user_token: "fake_token", password: "attacker_password"
        expect(alice.reload.authenticate("attacker_password")).to be_false
      end

      it "redirects to the expired token path" do
        alice = Fabricate(:user)
        post :create, user_token: "fake_token", password: "attacker_password"
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end