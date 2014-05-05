require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to the home page if user authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end #ends GET new
  
  describe "POST create" do
    context "valid login input" do
      
      it "sets session for signed in user" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        expect(session[:user_id]).to eq(bob.id)
      end  
      it "should redirect to home path" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        expect(response).to redirect_to home_path
      end
      it "displays success flash notice" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        expect(flash[:success]).to eq("You are signed in, enjoy your movies!")
      end
     end # ends valid input context
    
    context "invalid login input" do
      before do
        bob = Fabricate(:user)
        post :create, email: bob.email
      end
      
      it "does not put the user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "should redirect to login path" do
        expect(response).to redirect_to login_path
      end
      it "should display error flash message" do
        expect(flash[:danger]).not_to be_blank
      end
    end # ends invalid login context
   end # ends post create
  
  describe "GET destroy" do
    context "logout" do
      before do
        session[:user_id] = Fabricate(:user).id
        get :destroy 
      end
    it "should redirect to root path" do
      expect(response).to redirect_to root_path
    end
    
    it "should end user session" do
      expect(session[:user_id]).to be_nil
    end
    
    it "displays logout flash message" do
      expect(flash[:danger]).not_to be_blank
    end
   end # ends context logout
  end  # ends GET destroy
end # ends sessions controller test