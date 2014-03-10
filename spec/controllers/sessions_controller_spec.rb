require 'spec_helper'
require 'pry'

describe SessionsController do
  describe "GET new" do
    it "redirects logged-in user to home" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to :home
    end
    it "renders the new template if no user logged in " do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    context "good login" do
      it "sets the session id to the user id" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        (expect(session[:user_id])).to eq(user.id)
      end

      it "sets a success notice" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        (expect(flash[:success])).to_not eq(nil)
      end

      it "redirects to the home page" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(response).to redirect_to :home
      end
    end

    context "bad login" do
      it "flashes an error message" do
        user = Fabricate(:user)
        post :create, email: user.email, password: ""
        expect(flash[:danger]).to_not eq(nil)
      end
      it "redirects to a login path" do
        user = Fabricate(:user)
        post :create, email: user.email, password: ""
        expect(response).to redirect_to login_path
      end
    end
  end
end