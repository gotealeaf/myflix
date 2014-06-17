require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "should set @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do

    context "with valid values" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "should create the user" do
        expect(User.count).to eq(1)
      end

      it "should go to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid vallues" do
      before { post :create, user: { email: 'none', password: 'p'} }

      it "should not create the user" do
        expect(User.count).to eq(0)
      end

      it "should render the :new template" do
        expect(response).to render_template(:new)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

  end

end
