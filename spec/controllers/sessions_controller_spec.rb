require 'spec_helper'

describe SessionsController do
  let(:user) { Fabricate.create(:user) }

  describe "GET 'new'" do
    it "renders :new template" do
      get "new"
      response.should render_template(:new)
    end

    it "redirects to home_path if already signed in" do
      session[:user_id] = user.id
      get "new"
      response.should redirect_to(home_path)
    end
  end

  describe "POST 'create'" do

    context "with wrong email and/or password" do
      before do
        post :create, email: user.email, password: Faker::Internet.password
      end

      it "doesn't set session[:uesr_id]" do
        session[:user_id].should be_nil
      end

      it "sets error" do
        flash[:error].should == "Invalid email or password"
      end

      it "redirects to sign_in_path" do
        response.should redirect_to(sign_in_path)
      end
    end

    context "with correct email and password" do
      before do
        post :create, email: user.email, password: user.password
      end

      it "sets session[:user_id]" do
        session[:user_id].should == user.id
      end

      it "sets notice" do
        flash[:notice].should == "You are signed in, enjoy!"
      end

      it "redirects to home_path" do
        response.should redirect_to(home_path)
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
      response.should redirect_to(root_path)
    end
  end

end
