require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end

    it "sets @user variable" do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user)  }

      it "creates a user record" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign_in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { email: "mped@example.com", password: "password" }
      end

      it "does not create a user record" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user variable" do
        expect(assigns(:user)).to be_new_record
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
