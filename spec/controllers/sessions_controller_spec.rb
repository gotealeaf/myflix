require 'spec_helper'
require 'pry'

describe SessionsController do
  describe "GET new" do
    it "redirects authenticated user to home" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders the new template if no user authenticated" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid login credentials" do
      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(User.first.id)
      end

      it "sets a success notice" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to the home page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid login credentials" do
      it "does not put the user into the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + "asdfsakd"
        expect(session[:user_id]).to be_nil
      end

      it "flashes an error message" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + "asdfsakd"
        expect(session[:user_id]).to be_nil
        expect(flash[:danger]).not_to be_blank
      end

      it "redirects to the login page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + "asdfsakd"
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET destroy" do
    it "sets a success message to flash" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(flash[:success]).not_to be_blank
    end

    it "clears the session for the user" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end