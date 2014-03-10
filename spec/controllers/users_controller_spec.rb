require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user to User.new" do
      get :new 
      expect(assigns(:user)).to_not eq(nil)
      expect(assigns(:user)).to be_kind_of(User)
    end

    # skip template render, since assumed Rails functionality
  end

  describe "POST create" do
    context "input is valid" do
      before do 
        user_attr = Fabricate.attributes_for(:user)
        post :create, user: user_attr
      end
      it "creates a new user" do
        expect(assigns(:user)).to be_instance_of(User)
        expect(assigns(:user)).to be_valid
        expect(assigns(:user).save).to be_true
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end
    end

    context "input is invalid" do
      before do
        user_attr = Fabricate.attributes_for(:user, password: "")
        post :create, user: user_attr
      end
      it "does not save the user" do
        expect(assigns(:user)).to_not be_valid
        expect(assigns(:user).save).to_not be_true
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end
    end
    #will test various bad inputs at model layer, I assume
  end
end