require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets flash[:warning] if authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(flash[:warning]).to eq("You are already logged in.")
    end

    it "redirects to home_path if authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to(home_path)
    end

    it "sets @user to a new user if unauthenticated" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    it "sets @user" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(assigns(:user)).to be_an_instance_of(User)
    end

    it "redirects to sign_in_path if user is valid" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to redirect_to(sign_in_path)
    end

    it "renders the :new template if user is not valid" do
      post :create, user: Fabricate.attributes_for(:user, email: nil)
      expect(response).to render_template(:new)
    end
  end
end