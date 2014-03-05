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
      
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the videos path" do
        expect(response).to redirect_to videos_path
      end
    end
    context "with invalid input" do

      before do
        post :create, user: { full_name: "jane" }
      end

      it "does not create a record when input is invalid " do
        expect(User.count).to eq(0)
      end

      it "renders new template when input is invalid" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end

