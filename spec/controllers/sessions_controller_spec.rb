require 'spec_helper'

describe SessionsController do

  describe "GET new" do

    it "redirects to home path if user is authenticated" do
      
      session[:user_id] =  Fabricate(:user).id
      get :new 
      expect(response).to redirect_to home_path

    end
    
    it "renders new/sign-in template for non-logged in user" do
      get :new
      expect(response).to render_template :new
    end



  end

  describe "POST create" do
    context "with valid credentials" do
      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end
      it "creates a session id " do
        expect(session[:user_id]).to eq @user.id

      end
      it "displays notice about successful login" do
        expect(flash[:success]).to include "log" #alternative is to_not be_blank #eq "You are logged in"
      end
      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end
    
    end # context valid

    context "with invalid credentials" do
      before do
        @user = Fabricate(:user)
        post :create, email: @user.email
      end
      it "should not create a session" do
        
        expect(session[:user_id]).to be_nil
      end
      it "should render new template" do
        expect(response).to redirect_to sign_in_path
      end

      it "should flash notice about invalid login" do
        expect(flash[:danger]).to_not be_blank
      end

    end # context invalid

  end # POST create

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "should delete the session" do
      expect(session[:user_id]).to eq nil

    end

    it "should redirect to the root path" do
      expect(response).to redirect_to root_path
    end
    it "sets the notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end


end
