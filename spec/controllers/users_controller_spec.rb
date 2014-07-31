require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) {get :show, id: 3}
    end

    it "sets @user" do
      set_current_user
      lalaine = Fabricate(:user)
      get :show, id: lalaine.id
      expect(assigns(:user)).to eq(lalaine)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do  
        expect(User.count).to eq(1)
      end

      it "redirects the user to the sign in page" do
        expect(response).to redirect_to(:sign_in)
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { password: "password", username: "Big Dog"}
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "render the new template page" do
        expect(response).to render_template(:new)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
