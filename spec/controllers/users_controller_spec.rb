require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates user" do
        post :create, user: {email: "ss@google.com", password: "password", full_name: "steve" }
        expect(User.count).to eq(1)
      end
      it "redirects to sign_in_path" do
        post :create, user: {email: "ss@google.com", password: "password", full_name: "steve" }
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      it "does not create user" do
        post :create, user: { password: "password", full_name: "steve" }
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        post :create, user: { password: "password", full_name: "steve" }
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: { password: "password", full_name: "steve" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
