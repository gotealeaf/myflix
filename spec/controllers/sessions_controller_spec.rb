require 'spec_helper'

describe SessionsController do

  describe 'POST create' do
    context "sign in is valid" do

      before do
        @user = Fabricate(:user)
      end

      it "signs in a user from valid data" do
        post :create, email: @user.email, password: @user.password
        session[:user_id].should == @user.id
      end

      it "redirects to home" do
        post :create, email: @user.email, password: @user.password
        response.should redirect_to home_path
      end
    end

    context "sign in is INVALID" do

      it "generates NO session from INVALID data" do
        post :create, email: "", password: ""
        session[:user_id].should be_blank
      end

      it "redirects to sign in" do
        post :create, email: "", password: ""
        response.should redirect_to sign_in_path
      end
    end
  end
#####################################
  describe 'GET sign_out' do

      before do
#sign in the user
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end

      it "destroys the session" do
        get :destroy
        session[:user_id].should be_blank
      end
 
      it "redirects to front page" do
        get :destroy
        response.should redirect_to root_path
      end

  end

end
