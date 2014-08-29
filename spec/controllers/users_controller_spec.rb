require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "should create @user variable" do
      get :new
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do 
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates user" do
        User.count.should == 1
      end
      it "redirects to sign in path" do 
        response.should redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      before { post :create, user: { password: "password", full_name: "Bob Dylan" } }
      it "does not create the user" do
        User.count.should == 0
      end
      it "renders the new template" do
        response.should render_template :new
      end
      it "sets @user" do
        assigns(:user).should be_instance_of(User)
      end
    end
  end
end