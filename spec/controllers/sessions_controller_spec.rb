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
      let(:amanda){Fabricate(:user)}

      before do
        post :create, email: amanda.email, password: amanda.password
      end

      it "puts the signed-in user in the session" do
        expect(session[:user_id]).to eq(amanda.id)
      end

      it "redirects to home_path" do
        expect(response).to redirect_to home_path
      end

      it "sets the success-message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid input" do
    	before do
    	  amanda = Fabricate(:user)
        post :create, email: amanda.email
      end

      it "does not put the user in the session" do
        expect(session[:user_id]).to eq(nil)
      end

      it "redirects to sign_in" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the error-message" do
        expect(flash[:danger]).not_to be_blank
      end	
    end
  end

  describe "GET destroy" do
  	before do
  	  session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the user session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the successfull logout message" do
      expect(flash[:success]).not_to be_blank
    end
  end
end