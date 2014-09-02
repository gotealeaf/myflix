require 'spec_helper'

describe SessionsController do

  context "sign in is valid" do

    before do
      @user = Fabricate(:user)
    end

    describe 'POST create' do
      it "signs in a user from valid data" do
        post :create, email: @user.email, password: @user.password
        session[:user_id].should == @user.id
      end

      it "redirects to home" do
        post :create, email: @user.email, password: @user.password
        response.should redirect_to home_path
      end
    end
  end

  context "sign in is INVALID" do

    describe 'POST create' do
      it "generates NO session from INVALID data" do
        post :create, email: "", password: ""
        session[:user_id].should be_blank
      end

      it "redirects to home" do
        post :create, email: "", password: ""
        response.should redirect_to sign_in_path
      end
    end
  end

end
