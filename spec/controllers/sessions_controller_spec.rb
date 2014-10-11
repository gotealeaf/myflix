require 'spec_helper'

describe SessionsController do
  
  describe "GET new" do
    it "redirects to home if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
    
    it "renders the new template if user is unauthenticated" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST create" do
    context "user exists and password is authenticated" do
      before do
        darren = Fabricate(:user)
        post :create, email: darren.email, password: darren.password
      end
      it "adds the user_id to the session" do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "redirects to root" do
        expect(response).to redirect_to :root
      end
    end
    context "user exists and password is not authenticated" do
      it "renders the new template" do
        darren = Fabricate(:user)
        post :create, email: darren.email, password: 'wrong_password'
        expect(response).to render_template(:new)
      end
    end
    context "user does not exist" do
      it "renders the new template" do
        post :create, email: "random@random.com", password: "wrong_password"
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe "GET destroy" do
    before do
      darren = Fabricate(:user)
      post :create, email: darren.email, password: darren.password
      get :destroy
    end
    it "sets the session user_id to nil" do
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects to root" do
      expect(response).to redirect_to :root
    end
  end
  
end