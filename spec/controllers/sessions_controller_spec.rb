require 'spec_helper'

describe SessionsController do 
  describe "GET new" do
    it "render the new template for unauth users" do 
      get :new
      expect(response).to render_template :new
    end 
    it "redirects to home page for auth users" do 
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end 
  end

  describe "POST create" do 
    context "with valid credentials" do 
      before do 
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
      end
      it "puts the signed in user in the session" do 
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end 
      it "redirects to the home page" do 
        expect(response).to redirect_to home_path
      end 
      it "sets the notice" do 
       expect(flash[:notice]).not_to be_blank
      end 
    end 

    context "with invalid credentials" do 
      before do 
        alice = Fabricate(:user)
        post :create, email: alice.email, 
        password: alice.password + 'extra_password'
      end
      it "does not create the user in session" do 
        expect(session[:user_id]).to be_nil
      end 
      it "redirects to the root path" do 
        expect(response).to redirect_to sign_in_path
      end
      it "sets the notice" do 
        expect(flash[:error]).not_to be_blank
      end 
    end 
  end 

  describe "GET destroy" do 
    before do 
      set_current_user
      get :destroy 
    end 
    it "clears the session" do 
      expect(session[:user_id]).to be_nil
    end
    it "redirects to root path" do 
      expect(response).to redirect_to root_path
    end 
    it "sets the notice" do 
      expect(flash[:notice]).not_to  be_blank
    end 
  end
end 