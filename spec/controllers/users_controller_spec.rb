require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      user = Fabricate(:user)     
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do 
    context "with valid input" do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates a user record" do   
        expect(User.count).to eq(1)
      end
  
      it "redirects to sign in path" do   
        expect(response).to redirect_to sign_in_path      
      end
    end

    context "with invalid input" do

      before do
        post :create, user: { password: "password", full_name: "Rick Cid" }
      end 

      it "does not create a user record" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)   
      end
    end
  end
end