require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the :new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirect to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do

      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end

      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(@user.id)
      end
      it "redirect to the home page" do
        expect(response).to redirect_to home_path
      end
      it "sets the success massage" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do

      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password + 'asdfasde'
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "redirect to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
      it "set the error massage" do
        expect(flash[:danger]).not_to be_blank 
      end
    end
  end
end