require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "creates a new User object" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of User
    end
    it "renders the Register page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it "does not create a new user if any of the fields are invalid" do
      post :create, user: {password: 'joelevinger', full_name: 'Joe Levinger'}
      expect(User.first).to eq nil
    end
    it "renders new again if anything is invalid" do
      post :create, user: {password: 'joelevinger', full_name: 'Joe Levinger'}
      expect(response).to render_template :new
    end
    it "creates a new user if valid" do
      post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
      expect(User.first.email).to eq 'jlevinger@jtonedesigns.com'
    end
    it "creates a new session if valid" do
      post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
      expect(session[:user_id]).not_to eq nil
    end
    it "redirects to the root if valid" do
      post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
      expect(response).to redirect_to root_path
    end
  end
end