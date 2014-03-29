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
    context "with valid input" do
      before :each do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "sets @user" do
        expect(User.count).to eq(1)
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "with invalid input" do
      before :each do
        post :create, user: Fabricate.attributes_for(:user, password: nil)
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end