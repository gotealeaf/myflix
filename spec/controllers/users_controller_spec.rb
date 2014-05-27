require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "set @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do

    context "with valid input" do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "create the user" do
        expect(User.count).to eq(1)
      end
      it "redirect to sign in path" do
        expect(response).to redirect_to sign_in_path 
      end
    end

    context "with invalid input" do

      before do
        post :create, user: { password: "secret", full_name: "Anton Kolmakov"}
      end

      it "does not create the user" do
        expect(User.count).to eq(0) 
      end
      it "render the :new template" do
        expect(response).to render_template :new
      end
      it "set @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end  
  end
end
