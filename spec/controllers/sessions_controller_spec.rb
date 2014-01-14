require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects valid users to home page" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
    it "renders the sign_in page for invalid entries" do
      get :new
        expect(response).to render_template :new
    end
  end


  describe "Post create" do
    context "with valid credentials" do
      before  do
        # alice = Fabricate(:user)
        # post :create, email: alice.email, password: alice.password, full_name: alice.full_name
      end
      it "should create a new session" do 
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
        expect(session[:user_id]).to eq(alice.id)
      end
      it "should redirect to the home page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
          expect(response).to redirect_to home_path
      end
       it "should set the success message" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password, full_name: alice.full_name
        expect(flash[:notice]).not_to be_blank
      end

    end
    context "with invalid credentials" do
      
      it "should not set the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password+'asdf', full_name: alice.full_name
       expect(session[:user_id]).to be_nil
      end
      it "should redirect to the sign_in page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password+'asdf', full_name: alice.full_name
       expect(response).to redirect_to sign_in_path
      end
      it "should set the error message" do
        alice = Fabricate(:user)
        post :create, email: 'email', password: 'password', full_name: 'full_name'
        expect(flash[:error]).not_to be_blank
      end
    end

    context "with no user" do
      it "should not set the session" do
        post :create, email: 'email', password: 'password', full_name: 'full_name'
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'GET destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "should end the session" do
      expect(session[:user_id]).to be_nil
    end
    it "should set the success message" do
      expect(flash[:notice]).not_to be_blank
    end

  end

end