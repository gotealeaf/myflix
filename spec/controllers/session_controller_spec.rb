require 'spec_helper'
require 'pry'

describe SessionsController do
  describe "GET new" do
    it "redirects to home path if current user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders the new template if not current user" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe "POST create" do
    context "with user-password authentication" do
      it "creates a new session" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to home path" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(response).to redirect_to home_path
      end
      it "sets the flash notice" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(flash[:notice]).not_to be_blank
      end
    end
    context "without user-password authentication" do
      it "does not create a new session" do
        user = Fabricate(:user)
        post :create, email: user.email, password: ""
        expect(session[:user_id]).to eq(nil)
      end
      it "redirects to the sign in path" do
        user = Fabricate(:user)
        post :create, email: user.email, password: ""
        expect(response).to redirect_to sign_in_path
      end
      it "sets the flash error" do
        user = Fabricate(:user)
        post :create, email: user.email, password: ""
        expect(flash[:error]).not_to be_blank
      end
    end
  end
  describe "GET destroy" do
    it "nilifies session" do
      user = Fabricate(:user)
      post :create, email: user.email, password: user.password
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end
    it "sets the flash notice" do
      user = Fabricate(:user)
      post :create, email: user.email, password: user.password
      get :destroy
      expect(flash[:notice]).not_to be_blank
    end
    it "redirects to root path" do
      user = Fabricate(:user)
      post :create, email: user.email, password: user.password
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end