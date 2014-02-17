require 'spec_helper'

describe ResetPasswordFollowupController do
  describe "GET show" do
    it "should render show template if token is valid" do
      user = Fabricate(:user)
      get :show, id: user.token
      expect(response).to render_template :show
    end
    it "sets @token" do
      user = Fabricate(:user)
      user.update_column(:token, "12345")
      get :show, id: "12345"
      expect(assigns(:token)).to eq("12345")
    end
    it "should show the Expired Token page if not valid" do
      user = Fabricate(:user)
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end
  describe "POST create" do
    context "valid token" do
      it "redirects to the sign-in path" do
        user = Fabricate(:user, password: "old_password")
        post :create, token: user.token, password: "new_password"
        expect(response).to redirect_to sign_in_path
      end
      it "updates the password" do
        user = Fabricate(:user, password: "old_password")
        post :create, token: user.token, password: "new_password"
        expect(user.reload.authenticate("new_password")).to eq(user)
      end
      it "sets a flash message indicating that the password has been changed" do
        user = Fabricate(:user)
        post :create, token: user.token, password: "new_password"
        expect(flash[:success]).to be_present
      end
      it "replaces the token" do
        user = Fabricate(:user)
        old_token = user.token
        post :create, token: user.token, password: "new_password"
        expect(old_token).not_to eq(user.reload.token)
      end
    end
    context "invalid token" do
      it "redirects to the Expired page" do
        user = Fabricate(:user)
        post :create, token: "123", password: "new_password"
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end