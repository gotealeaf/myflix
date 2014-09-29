require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "displays sign in page for non-logged in user" do
      get :new
      response.should render_template :new
    end

    it "redirects to home for logged-in user" do
      set_current_user
      @user = current_user
      get :new
      response.should redirect_to home_path
    end
  end

  describe 'POST create' do
    context "sign in is valid" do

      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end

      it "signs in a user from valid data" do
        session[:user_id].should == @user.id
      end

      it "redirects to home" do
        response.should redirect_to home_path
      end

      it "sets the notice" do
        flash[:notice].should_not be_blank
      end

    end

    context "sign in is INVALID" do

      before do
        post :create, email: "", password: ""
      end

      it "generates NO session from INVALID data" do
        session[:user_id].should be_blank
      end

      it "redirects to sign in" do
        response.should redirect_to sign_in_path
      end

      it "sets the error" do
        flash[:error].should_not be_blank
      end

    end
  end
#####################################
  describe 'GET sign_out' do

      before do
#sign in the user
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
        get :destroy
      end

      it "destroys the session" do
        session[:user_id].should be_blank
      end
 
      it "redirects to front page" do
        response.should redirect_to root_path
      end

      it "sets the notice" do
        flash[:notice].should_not be_blank
      end

  end

end
