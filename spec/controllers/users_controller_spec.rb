require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "creates a new User object" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "renders the Register page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context "with valid input" do
      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates a new user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the root" do
        expect(response).to redirect_to root_path
      end
      it "creates a new session" do
        post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
        expect(session[:user_id]).not_to eq nil
      end
    end
    context "with invalid input" do
      before do
        post :create, user: { password: 'joelevinger', full_name: 'Joe Levinger' }
      end
      it "does not create a new user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template again" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end