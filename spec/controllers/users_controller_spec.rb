require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do
    it "sets @user" do
      post :create, user: { fullname: 'desmond', password: 'password'}
      expect(assigns(:user)).to be_instance_of(User)
    end
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to login path if success" do
        expect(response).to redirect_to login_path
      end
    end
    context "with invalid input" do
      before do
        post :create, user: { fullname: 'desmond', password: 'password'}
      end
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders new template if fail" do
        expect(response).to render_template :new
      end
    end
  end
end
