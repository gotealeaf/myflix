require 'spec_helper'
require 'pry'

describe UsersController do

  describe "GET new"
    it "redirects the user away from the sign in page if user is authenticated" do
      session[:user_id] = Fabricate(:user).id

      get :new
      expect(response).to redirect_to videos_path
    end
    it "sets the @user variable if the user is inauthenticated" do
      user = Fabricate.build(:user)

      get :new
      expect(assigns(:user)).to be_new_record
    end
    it "sets the @user variable which is an instance of the User class" do
      user = Fabricate.build(:user)

      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

  describe "POST create"
    it "adds a new record to the database when input is valid" do
      user = Fabricate(:user)
      post :create, user: {full_name: user.full_name, email: user.email, password: user.password}
      
      expect(User.first.full_name).to eq(user.full_name)
      expect(User.first.email).to eq(user.email)
      expect(User.first.password_digest).to eq(user.password_digest)
    end

    it "does not create a record when input is invalid " do
      post :create, user: { full_name: "jane" }

      expect(User.count).to eq(0)
    end

    it "renders new template when input is invalid" do
      post :create, user: { full_name: "jane" }
      expect(response).to render_template :new
    end
end

