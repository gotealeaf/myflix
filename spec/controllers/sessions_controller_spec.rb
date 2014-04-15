require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home_path if authenticated" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "sets @user" do
      user = Fabricate(:user)
      post :create, email: user.email
      expect(assigns(:user)).to eq user
    end

    context "with valid credentials" do
      let(:user) { Fabricate(:user) }

      before { post :create, email: user.email, password: user.password }

      it "sets the session" do
        expect(session[:user_id]).to eq user.id
      end

      it "sets the notice message" do
        expect(flash[:info]).not_to be_empty
      end

      it "redirects to home_path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid credentials" do
      before { post :create, email: Fabricate(:user).email, password: nil }

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the warning message" do
        expect(flash[:warning]).not_to be_empty
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET destroy" do
    before { set_current_user; get :destroy }

    it "removes user from session" do
      expect(session[:id]).to be_nil
    end

    it "sets the info message" do
      expect(flash[:info]).not_to be_empty
    end

    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end
  end
end