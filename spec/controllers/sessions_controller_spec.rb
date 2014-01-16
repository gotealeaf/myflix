require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'redirect to the home path if current_user' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    it 'renders the new template for uncurrent_user' do
      get :new
      expect(response).to  render_template :new
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before do
        @sam = Fabricate(:user)
        post :create , email: @sam.email, password: @sam.password
      end
      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(@sam.id) 
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
        sam = Fabricate(:user)
        post :create , email: sam.email, password: sam.password + "ald"
      end
      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "redircts to the sign in page" do
        expect(response).to redirect_to sign_in_path 
      end
      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end 
    end
  end

  describe "GET destroy" do
    before do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "clean the sessions" do
      expect(session[:user_id]).to be_nil 
    end
    it "redirects to the root_path" do
      expect(response).to redirect_to root_path 
    end
    it "sets the notice message" do
      expect(flash[:notice]).not_to be_blank
    end 
  end 
end
