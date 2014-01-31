require 'spec_helper'

describe ResetPasswordsController do
  describe 'GET show' do
    it "renders the show page if token is valid" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(response).to render_template :show
    end
    it "sets the token" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(assigns(:token)).to eq("12345")
    end
    it "renders the expired token page if tokne is not valid" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id: "invalid_token"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "should redirect to sign_in" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: 'new_password'
        expect(response).to redirect_to sign_in_path
       end

      it "should update the users password" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: 'new_password'
        expect(alice.reload.authenticate("new_password")).to be_true
      end
     
      it "should set flash message" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: 'new_password'
        expect(flash[:success]).to be_present
      end

      it "should regenerate token" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: 'new_password'
        expect(alice.reload.token).not_to eq("12345")
      end
    end

    context "with invalid token" do
      it "should not update password"  do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "invalid_token", password: 'new_password'
        expect(alice.reload.token).to eq("12345")
      end
      it "should redirect to expired token path" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, "12345")
        post :create, token: "invalid_token", password: 'new_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end