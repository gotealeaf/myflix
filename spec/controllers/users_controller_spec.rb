require 'rails_helper.rb'

describe UsersController do

  describe "GET new" do
    it "sets new @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input data" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to videos_path" do
        expect(response).to redirect_to videos_path
      end
    end

    context "with invalid input data" do
      before do
        post :create, user: { password: "password", full_name: "Josh Leeman}" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets new @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
