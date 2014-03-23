require 'spec_helper'

describe SessionsController do
  let(:user) { Fabricate.create(:user) }

  describe "GET 'new'" do
    it "renders :new template" do
      get "new"
      expect(response).to render_template :new
    end

    it "redirects to home_path if already signed in" do
      session[:user_id] = user.id
      get "new"
      expect(response).to redirect_to home_path
    end
  end

  describe "POST 'create'" do

    context "with wrong email and/or password" do
      before do
        post :create, email: user.email, password: Faker::Internet.password
      end

      it "doesn't set session[:uesr_id]" do
        expect(session[:user_id]).to be_nil
      end

      it "sets error" do
        expect(flash[:error]).to eq("Invalid email or password")
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with correct email and password" do
      before do
        post :create, email: user.email, password: user.password
      end

      it "sets session[:user_id]" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets notice" do
        expect(flash[:notice]).to eq("You are signed in, enjoy!")
      end

      it "redirects to home_path" do
        expect(response).to redirect_to home_path
      end
    end
  end

  describe "GET 'destroy'" do

    it "sets session[:user_id] to nil" do
      post :create, email: user.email, password: user.password
      expect { get "destroy" }.to change{ session[:user_id] }.from(user.id).to(nil)
    end

    it "redirects to root_path" do
      get "destroy"
      expect(response).to redirect_to root_path
    end
  end

end
