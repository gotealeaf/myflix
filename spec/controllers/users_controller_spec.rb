require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user instance variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end # ends the GET new test
  
  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user) 
      end
      it "creates a new user" do
        expect(User.count).to eq(1) 
      end
      
      it "redirects to videos path" do
        response.should redirect_to videos_path
      end
    end # ends context with valid input
    
    context "with invalid input" do
      before do
        post :create, user: { email: "user@example.com", password: "password" }
      end
      it "does not create a user" do
        expect(User.count).to eq(0)
      end
      
      it "renders the new template if user is unable to be created" do
        response.should render_template :new
      end
      
      it "sets the @user instance variable to be used in the new template" do
        assigns(:user).should be_instance_of(User)
      end  
    end # ends context with invalid input
  end #ends POST create 
end # ends users controller test