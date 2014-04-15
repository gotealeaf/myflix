require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user to User.new" do
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "input is valid" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do
        expect(assigns(:user)).to be_instance_of(User)
        expect(assigns(:user)).to be_valid
        expect(assigns(:user).save).to be_true
        expect(User.count).to eq(1)
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end
    end

    context "input is invalid" do
      before { post :create, user: Fabricate.attributes_for(:user, password: "") }
      
      it "does not save the user" do
        expect(assigns(:user)).to_not be_valid
        expect(assigns(:user).save).to_not be_true
        expect(User.count).to eq(0)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end
    end
  end
end