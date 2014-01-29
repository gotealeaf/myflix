require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable" do
      user = Fabricate(:user)
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user)}

      it "creates a user " do
        expect(User.count).to eq(1)
      end
      it "should redirect to sign in page" do
        expect(response).to redirect_to sign_in_path 
      end
    end

    context "with invalid input" do
      before { post :create, user: Fabricate.attributes_for(:user, email: nil)}

      it "doesn't create a new user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets the @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET show" do

    it_behaves_like "requires sign in" do
      let(:action) {get :show, id: 3}
    end
    it "should set @user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end
end  