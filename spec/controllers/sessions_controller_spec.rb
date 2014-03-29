require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home_path if authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to(home_path)
    end

    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "sets user" do
      user_1 = Fabricate(:user)
      post :create, email: user_1.email
      expect(assigns(:user)).to eq(user_1)
    end

    context "with valid credentials" do
      before :each do
        @fake_user = Fabricate(:user)
        post :create, email: @fake_user.email, password: @fake_user.password
      end

      it "sets the session" do
        expect(session[:user_id]).to eq(@fake_user.id)
      end

      it "sets the notice message" do
        expect(flash[:info]).not_to be_empty
      end

      it "redirects to home_path" do
        expect(response).to redirect_to(home_path)
      end
    end

    context "with invalid credentials" do
      before :each do
        @fake_user = Fabricate(:user)
        post :create, email: @fake_user.email, password: nil
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the warning message" do
        expect(flash[:warning]).not_to be_empty
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "GET destroy" do
    before :each do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "removes user from session" do
      expect(session[:id]).to be_nil
    end

    it "sets the info message" do
      expect(flash[:info]).not_to be_empty
    end

    it "redirects to root_path" do
      expect(response).to redirect_to(root_path)
    end
  end
end