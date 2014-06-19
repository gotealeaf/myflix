require 'rails_helper'

describe SessionsController do

  describe "GET new" do
    it "redirects to home_path if signed in" do
      cookies[:auth_token] = Fabricate(:user).auth_token
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders :new if not signed in" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do

    context "with valid credentials" do
      let(:batman) {Fabricate(:user)}

      before do
        post :create, email: batman.email, password: batman.password
      end

      it "sets auth_token in cookie" do
        expect(cookies[:auth_token]).to eq(batman.auth_token)
      end

      it "redirects to home_path" do
        expect(response).to redirect_to home_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end

    end

    context "with invalid credentials" do
      before do
        batman = Fabricate(:user)
        post :create, email: batman.email, password: batman.password + 'extra'
      end

      it "does not put auth token in a cookie" do
        expect(cookies[:auth_token]).to be_nil
      end

      it "renders :new if unsuccessful" do
        expect(response).to render_template(:new)
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).not_to be_blank
      end
    end


  end

  describe "GET destroy" do
    before do
      cookies[:auth_token] = Fabricate(:user).auth_token
      get :destroy
    end

    it "clears the auth_token from the cookie" do
      expect(cookies[:auth_token]).to be_blank
    end

    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end

    it "sets the flash info message" do
      expect(flash[:info]).not_to be_blank
    end
  end

end
