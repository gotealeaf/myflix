require 'spec_helper'

describe PasswordResetsController do
  
  describe "GET show" do
    it "renders the show template if the token is valid" do
      darren = Fabricate(:user)
      darren.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end
    it "sets @token" do
      darren = Fabricate(:user)
      darren.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end
    it "redirects to the invalid token page if the taken is invalid" do
      get :show, id: '12345'
      expect(response).to redirect_to invalid_token_path
    end
  end
  
  describe "POST create" do
    context "with valid token" do
      it "redirects to the sign in page" do
        darren = Fabricate(:user, password: 'old_password')
        darren.update_column(:token, '12345')
        post :create, password: 'new_password', token: '12345'
        expect(response).to redirect_to sign_in_path
      end
      it "updates the user's password" do
        darren = Fabricate(:user, password: 'old_password')
        darren.update_column(:token, '12345')
        post :create, password: 'new_password', token: '12345'
        expect(darren.reload.authenticate('new_password')).to be_truthy
      end
      it "sets the flash success message" do
        darren = Fabricate(:user, password: 'old_password')
        darren.update_column(:token, '12345')
        post :create, password: 'new_password', token: '12345'
        expect(flash[:success]).to eq("Your password has been changed. Please sign in.")
      end
      it "regenerates the user's token" do
        darren = Fabricate(:user, password: 'old_password')
        darren.update_column(:token, '12345')
        post :create, password: 'new_password', token: '12345'
        expect(darren.reload.token).not_to eq('12345')
      end
    end
    context "with invalid token" do
      it "redirects to the invalid token path" do
        post :create, password: 'new_password', token: '12345'
        expect(response).to redirect_to invalid_token_path
      end
    end
  end
  
end