require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template(:new)
    end
    it "redirects to home path for auhenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end
  describe "POST create" do
    context "with valid credentials" do
      before do
        @desmond = Fabricate(:user)
        post :create, email: @desmond.email, password: @desmond.password
      end
      it "puts the login user in session" do
        expect(session[:user_id]).to eq(@desmond.id)
      end
      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end
      it "sets the info" do
        expect(flash[:info]).not_to be_blank
      end
    end
    context "with invalid credentials" do
      before do
        desmond = Fabricate(:user)
        post :create, email: desmond.email, password: desmond.password + "1"
      end
      it "does not put the login user in session" do
        expect(session[:user_id]).to be_nil
      end
      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
      it "sets the warning" do
        expect(flash[:warning]).not_to be_blank
      end
    end
  end
  describe "POST destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "clears session for current user" do
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end
    it "set the info" do
      expect(flash[:info]).not_to be_blank
    end
  end
end

