require 'spec_helper'

describe SessionsController do

  let(:user) { Fabricate(:user) }

  describe "sessions#new" do
    it "renders :new if logging in" do
      set_current_user
      get :new
      expect(response).to render_template :new
    end
  end
  
  describe "sessions#create" do
    context "authenticating successfully" do
      before(:each) do
        post :create, name: user.name, password: user.password
      end
      it "assigns user_id to session[:user_id]" do
        expect(session[:user_id]).to eq user.id
      end
      it "redirects to videos_path" do
        expect(response).to redirect_to videos_path
      end
    end

    context "failing authentication" do
      before(:each) do
        post :create, name: user.name, password: "wrong pw"
      end
      it "redirects to login_path" do
        expect(response).to redirect_to login_path  
      end
      it "sets error message" do
        expect(flash[:error]).not_to be_blank
      end
    end

    describe "sessions#destroy" do
      before(:each) do
        set_current_user
        delete :destroy
      end
      it "logs out" do
        expect(session[:user_id]).to be_nil 
      end
      it "redirects to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
