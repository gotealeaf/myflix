require 'spec_helper'

describe UsersController do

  describe "GET #new" do
    it "assigns @user" do 
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the new user template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "valid input" do
      before {post :create, user: Fabricate.attributes_for(:user)}
      it "creates a new user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        expect(response).to redirect_to(:sign_in)
      end
    end
    
    context "invalid input" do
      before {post :create, user: {email: "test@example.com", full_name: "Test User", password: ""}}
      it "does not create a User" do
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        expect(response).to render_template(:new)
      end
      it "assigns @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
  
end
