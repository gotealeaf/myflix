require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "for unauthenticated users renders new template" do
      get :new
      expect(response).to render_template :new
    end
    it "for authenticated users redirects to home_path" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before do
        steve = Fabricate(:user)
        post :create, email: steve.email, password: steve.password
     end
      it "it puts user in a session" do
        steve = Fabricate(:user)
        post :create, email: steve.email, password: steve.password
        expect(session[:user_id]).to eq(steve.id)
      end
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end
    context "with invalid credentials"
    it "does not put signed in user in the session" do
      steve = Fabricate(:user)
      post :create, email: steve.email, password: steve.password + 'asd'
      expect(flash[:notice]).to be_nil
    end
    it "redirects to sign in page" do
      steve = Fabricate(:user)
      post :create, email: steve.email, password: steve.password + 'asd'
      expect(response).to redirect_to sign_in_path
    end
    it "sets the error message" do
      steve = Fabricate(:user)
      post :create, email: steve.email, password: steve.password + 'asd'
      expect(flash[:error]).not_to be_blank
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "ends the user session" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
    it "sets the notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
end
