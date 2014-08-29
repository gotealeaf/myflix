require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    context "authenticated user" do
      it "redirects to home_path" do
        session[:user_id] = Fabricate(:user).id
        get :new
        response.should redirect_to home_path
      end
    end

    context "unathenticated user" do
      it "renders the new template" do
        get :new
        response.should render_template :new
      end
    end
  end

  describe "POST create" do
    context "authenticated user" do 

      it "sets the session[:user_id]" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        session[:user_id].should == bob.id 
      end
      it "redirects to home_path" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        response.should redirect_to home_path
      end
      it "sets the notice" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        flash[:notice].should_not be_blank
      end
    end

    context "unauthenticated user" do
      it "redirects to sign_in_path" do
        post :create
        response.should redirect_to sign_in_path
      end

      it "sets the error message" do
        post :create
        flash[:error].should_not be_blank
      end
    end
  end

  describe "GET destroy" do
    before do 
      bob = Fabricate(:user) 
      session[:user_id] = bob.id
    end
    it "clears the user cookie" do 
      get :destroy
      session[:user_id].should be_nil
    end
    it "redirect_to root path" do
      get :destroy
      response.should redirect_to root_path
    end
    it "sets the notice" do
      get :destroy
      flash[:notice].should_not be_blank
    end
  end
end