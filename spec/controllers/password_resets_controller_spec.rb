require 'spec_helper'

describe PasswordResetsController do
  describe "GET edit" do
    it "renders edit template if the token is valid" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :edit, id: "12345"
      expect(response).to render_template :edit
    end
    it "sets @token" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :edit, id: "12345"
      expect(assigns(:token)).to eq('12345')
    end
    it "redirects to the expired token page if the token is not valid" do
      get :edit, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "PUT update" do
    context "with valid token" do
      it "redirects to the sign in page" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
        put :update, id: "12345", user: { password: "new_password" }
        expect(response).to redirect_to sign_in_path
      end
      it "updates the user's password" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
        put :update, id: "12345", user: { password: "new_password" }
        expect(alice.reload.authenticate('new_password')).to be_true
      end
      it "sets the flash success message" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
       put :update, id: "12345", user: { password: "new_password" }
        expect(flash[:success]).to be_present
      end
      it "regenerates the user token" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
        put :update, id: "12345", user: { password: "new_password" }
        expect(alice.reload.token).not_to eq('12345')
      end
    end
    context "with invalid token" do
      it "redirects to the expired token path" do
        put :update, id: "12345", user: { password: "some_password" }
        expect(response).to redirect_to expired_token_path
      end
      it "render the edit page if password field is blank" do
        alice = Fabricate(:user, password: "old_password")
        alice.update_column(:token, "12345")
        put :update, id: "12345", user: { password: "" }
        expect(response).to render_template :edit
      end
    end
  end
end
