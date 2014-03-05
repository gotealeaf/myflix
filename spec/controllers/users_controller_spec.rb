require 'spec_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if the user is inauthenticated" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates the user" do
        post :create, user: { full_name: "Bill", email: "bill@example.com", password: 'password' }
        
        expect(User.count).to eq(1)
      end

      it "redirects to the videos path" do
        post :create, user: { full_name: "Bill", email: "bill@example.com", password: 'password' }
        expect(response).to redirect_to videos_path
      end
    end
    context "with invalid input" do
      it "does not create a record when input is invalid " do
        post :create, user: { full_name: "jane" }
        expect(User.count).to eq(0)
      end

      it "renders new template when input is invalid" do
        post :create, user: { full_name: "jane" }
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: { full_name: "jane" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end

