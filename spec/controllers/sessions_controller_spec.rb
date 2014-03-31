require 'spec_helper'

describe SessionsController do


  describe "GET new" do
    it "redirects users who are already signed in" do
      session[:user_id] = 1
      get :new
      expect(response).to redirect_to root_path
    end
    it "renders the template for guests not signed in" do
      get :new
      expect(response).to render_template :new
    end
  end


  describe "POST create" do
    joe = Fabricate(:user)

    it "signs user in with correct information" do
      post :create, {email: joe.email, password: joe.password}
      expect(session[:user_id]).to eq(joe.id )
    end
    it "flashes welcome notice with correct information" do
      post :create, {email: joe.email, password: joe.password}
      expect(flash[:notice]).to_not be_empty
    end
    it "re-renders /signin page for wrong email" do
      post :create, {email: "", password: joe.password}
      expect(response).to render_template :new
    end
    it "flashes error notice for wrong email" do
      post :create, {email: "", password: joe.password}
      expect(flash[:error]).to_not be_empty
    end
    it "re-renders /signin page for wrong password" do
      post :create, {email: joe.email, password: ""}
      expect(response).to render_template :new
    end
    it "flashes error notice for wrong password" do
      post :create, {email: joe.email, password: ""}
      expect(flash[:error]).to_not be_empty
    end
    it "redirects users who are already signed in" do
      session[:user_id] = 1
      post :create
      expect(response).to redirect_to root_path
    end
  end


  describe "GET destroy" do
    context "for signed in users" do
      before do
        session[:user_id] = 1
        get :destroy
      end

      it "signs out(clears) the user's session" do
        expect(session[:user_id]).to eq(nil)
      end
      it "flashes error notice upon signout" do
        expect(flash[:notice]).to_not be_empty
      end
      it "redirects the user after signout" do
        expect(response).to redirect_to root_path
      end
    end

    context "for guests" do
      it "redirects guests who are already signed out" do
        session[:user_id] = nil
        get :destroy
        expect(response).to redirect_to root_path
      end
    end
  end
end
