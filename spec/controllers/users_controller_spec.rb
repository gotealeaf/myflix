require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "sets the @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "Post create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "create user" do
        expect(User.count).to eq(1)
      end
      it "redirect to sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invladie input"
      before do
        post :create, user: { password: "password", full_name: "AJ Jones" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "redirects to :new template" do
         expect(response).to render_template :new
      end
      it "sets the @user" do
         expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
