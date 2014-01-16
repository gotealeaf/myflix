require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home path for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new 
    end
  end

  describe "POST create" do 
    context "with valid input" do
      it "puts the signed-in user in the session" do
        amanda = Fabricate(:user)
        post :create, email: amanda.email, password: amanda.password
        expect(session[:user_id]).to eq(amanda.id)
      end

      it "redirects to home_path" do
        amanda = Fabricate(:user)
        post :create, email: amanda.email, password: amanda.password
        expect(response).to redirect_to home_path
      end

      it "sets the success-message" do
        amanda = Fabricate(:user)
        post :create, email: amanda.email, password: amanda.password
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid input" do
      it "does not put the user in the session" do
        amanda = Fabricate(:user)
        post :create, email: amanda.email	
        expect(session[:user_id]).to eq(nil)
      end
      
      it "redirects to sign_in" do
        amanda = Fabricate(:user)
        post :create, email: amanda.email
        expect(response).to redirect_to sign_in_path
      end

      it "sets the error-message" do
      	amanda = Fabricate(:user)
        post :create, email: amanda.email
        expect(flash[:danger]).not_to be_blank
      end	
    end
  end
end