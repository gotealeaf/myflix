require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it "renders the Sign In page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it "does not create a new session if the email is invalid" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'joe@example.com', password: 'joelevinger'
      expect(session[:user_id]).to eq nil
    end
    it "does not create a new session if the password is invalid" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'jlevinger@jtonedesigns.com', password: 'abc'
      expect(session[:user_id]).to eq nil
    end
    it "renders new again if anything is invalid" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'jlevinger@jtonedesigns.com', password: 'abc'
      expect(response).to render_template :new
    end
    it "creates a new session if valid" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'jlevinger@jtonedesigns.com', password: 'joelevinger'
      expect(session[:user_id]).to eq my_user.id
    end
    it "redirects to the root if valid" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'jlevinger@jtonedesigns.com', password: 'joelevinger'
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET destroy' do
    it "makes the session user id nil" do
      my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
      post :create, email: 'jlevinger@jtonedesigns.com', password: 'joelevinger'
      get :destroy
      expect(session[:user_id]).to eq nil
    end
  end
end