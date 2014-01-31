require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it "renders the Sign In page for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to videos_path
    end
  end

  describe 'POST create' do
    context "with valid credentials" do
      before { create_user_valid_credentials }
      it "creates a new session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end
      it "redirects to the root" do
        expect(response).to redirect_to root_path
      end
      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end
    context "with invalid credentials" do
      before { create_user_invalid_credentials }
      it "does not create a new session because of invalid email" do
        alice = Fabricate(:user)
        post :create, email: alice.email + '.com', password: alice.password
        expect(session[:user_id]).to be_nil
      end
      it "does not create a new session because of invalid password" do
        expect(session[:user_id]).to be_nil
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before { destroy_session }
    it "makes the session user id nil" do
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