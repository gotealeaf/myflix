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
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
      end

      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it "sets a success notice" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid login credentials" do
      before do

      end

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

      it_behaves_like "requires login" do
        alice = Fabricate(:user)
        let(:action) { post :create, email: alice.email, password: alice.password + "asdfsakd" } 
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "sets a success message to flash" do
      expect(flash[:success]).not_to be_blank
    end

    it "clears the user session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end