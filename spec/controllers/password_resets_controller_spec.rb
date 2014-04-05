require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      amanda = Fabricate(:user)
      amanda.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "sets @token" do
      amanda = Fabricate(:user)
      amanda.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to the expired token page if the token is invalid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do 
    context "with valid token" do
      it "updates the user's password" do
        amanda = Fabricate(:user, password: 'old password')
        amanda.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(amanda.reload.authenticate('new_password')).to be_true
      end


      it "redirects to the sign in page" do
        amanda = Fabricate(:user, password: 'old password')
        amanda.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end

      it "sets the flash success message" do
        amanda = Fabricate(:user, password: 'old password')
        amanda.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end

      it "regenerates the token" do
        amanda = Fabricate(:user, password: 'old password')
        amanda.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(amanda.reload.token).not_to eq('12345')
      end 


    end
  

    context "with invalid token" do
      it "redirects to the expired token path" do
        post :create, token: '12345', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
