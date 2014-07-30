require 'spec_helper'
require 'pry'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    it "saves the new user in the database for valid attributes" do
      user = Fabricate(:user)
      post :create, user: { email: user.email, password: user.password, name: user.name } 
      #alternative: post :create, user: Fabricate.attributes_for(:user)
      expect(User.count).to eq(1)
    end

    it "redirects to sign in page for valid attributes" do
      post :create, user: { email: "johnny@appleseed.com", password: "apples", name: "J Appz" } 
      expect(response).to redirect_to sign_in_path
    end

    it "does not save the new user for invalid attributes" do
      post :create, user: { email: "johnny@appleseed.com", password: "apples"} 
      expect(User.count).to eq(0)
    end

    it "renders new template for invalid attributes" do
      post :create, user: { email: "johnny@appleseed.com", password: "apples"} 
      expect(response).to render_template :new
    end

  end
end
