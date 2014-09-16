require 'spec_helper'

describe PasswordResetsController do 
  describe "GET show" do
    it "renders show template if the token is valid" do
      karen = Fabricate(:user)
      karen.update_column(:token, '123456')
      get :show, id: '123456'
      response.should render_template :show
    end

    it "sets @token" do
      karen = Fabricate(:user)
      karen.update_column(:token, '123456')
      get :show, id: '123456'
      assigns(:token).should == '123456'
    end
    it "redirects to the expired token page if token is invalid" do
      get :show, id: '123456'
      response.should redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to the sign in page" do
        karen = Fabricate(:user, password: 'old_password')
        karen.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        response.should redirect_to sign_in_path
      end
      it "updates the user's password" do
        karen = Fabricate(:user, password: 'old_password')
        karen.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        karen.reload.authenticate('new_password').should be_true
      end
      
      it "sets the flash success message" do
        karen = Fabricate(:user, password: 'old_password')
        karen.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        flash[:success].should be_present
      end
      it "regenerates the user token" do 
        karen = Fabricate(:user, password: 'old_password')
        karen.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        karen.reload.token.should_not == '1234'        
      end
    end
    context "with invalid token" do
      it "redirects to the expired_token_path" do
        post :create, token: '12345', password: 'some_password'
        response.should redirect_to expired_token_path
      end
    end
  end
  
end