require 'spec_helper'

describe SessionsController do
  context "with autenticated user" do 
    before { session[:user_id] = Fabricate(:user).id }
    describe "GET #new" do
      it "redirects to home path" do
        get :new
        expect(response).to redirect_to home_path
      end
    end
    describe "POST #create" do
      it "redirects to home path" do
        post :create
        expect(response).to redirect_to home_path
      end
    end
    describe "POST #destroy" do
      it "sets session[:user_id] to nil" do
        post :destroy
        expect(session[:user_id]).to be_nil
      end
      it "redirects to root path" do 
        post :destroy
        expect(response).to redirect_to root_path
      end
      it "sets the success notice" do 
        post :destroy
        expect(flash[:success]).not_to be_blank
      end
    end
  end

  context "with unauthenticated user" do
    describe "POST #create" do
      context "with valid credentials" do
        let(:user) { Fabricate(:user, password: "password") }
        before { post :create, email: user.email, password: "password" }
        it "sets session[:user_id] to the user's id" do
          expect(session[:user_id]).to eq(user.id)
        end
        it "redirects to the home path" do
          expect(response).to redirect_to home_path
        end
        it "sets the success notice" do 
          expect(flash[:success]).to be_true
        end
      end
      context "with invalid credentials" do
        let(:user) { Fabricate(:user) }
        before { post :create, email: user.email, password: "password" }
        it "doesn't log in the user" do
          expect(session[:user_id]).to be_nil
        end
        it "redirects to the login path" do 
          expect(response).to redirect_to login_path
        end
        it "shows a danger notice" do
          expect(flash[:danger]).to be_true
        end
      end
    end
    describe "POST #destroy" do
      it "redirects to root path" do 
        post :destroy
        expect(response).to redirect_to root_path
      end
    end
  end
end