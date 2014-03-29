require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "should render the show page if token is valid" do
      desmond = Fabricate(:user)
      get :show, id: desmond.token
      expect(response).to render_template :show
    end
    it "should set token variable" do
      desmond = Fabricate(:user)
      get :show, id: desmond.token
      expect(assigns(:token)).to eq(desmond.token)
    end
    it "should redirect to token expired page if token is invalid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "should redirect to login page" do
        desmond = Fabricate(:user, password: "1234")
        post :create, password: "12345", token: desmond.token
        expect(response).to redirect_to login_path
      end
      it "should update user's password" do
        desmond = Fabricate(:user, password: "1234")
        post :create, password: "12345", token: desmond.token
        expect(desmond.reload.authenticate("12345")).to be_true
      end
      it "should show success message" do
        desmond = Fabricate(:user, password: "1234")
        post :create, password: "12345", token: desmond.token
        expect(flash[:info]).to be_present
      end
      it "should regenerate user token" do
        desmond = Fabricate(:user, password: "1234")
        desmond.update_column(:token, 'desmond')
        post :create, password: "12345", token: desmond.token
        expect(desmond.reload.token).not_to eq('desmond')
      end
    end

    context "with invalid token" do
      it "should redirect to token expired page" do
        post :create, password: "12345", token: '1234'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
