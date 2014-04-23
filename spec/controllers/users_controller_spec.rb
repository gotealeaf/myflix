require 'spec_helper'

describe UsersController do
  describe "GET new" do
    let(:action) { get :new }

    it "sets warning if authenticated" do
      set_current_user
      action
      expect(flash[:warning]).to eq "You are already logged in."
    end

    it "redirects to home path if authenticated" do
      set_current_user
      action
      expect(response).to redirect_to home_path
    end

    it "sets @user to a new user if unauthenticated" do
      action
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq 1
      end

      it "redirects to sign in" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      before { post :create, user: Fabricate.attributes_for(:user, password: nil) }

      it "does not create the user" do
        expect(User.count).to eq 0
      end

      it "renders the new user template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of User
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    before { set_current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: user.id }
    end

    it "renders the user show path" do
      get :show, id: user.id
      expect(response).to render_template :show
    end

    it "sets @user" do
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end
  end

  describe "POST follow" do
    it "redirects to the followed user's profile page"
  end
end