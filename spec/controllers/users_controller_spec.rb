require 'spec_helper'

describe UsersController do

  let(:hank)  { Fabricate(:user) }

  describe 'GET show' do
    it_behaves_like "require_sign_in" do
      let(:action) {get :show, id: 1}
    end

    it "prepares the user instance variable" do
      set_current_user(hank)
      get :show, id: 1
      expect(assigns(:user)).to eq(hank)
      end
  end

  describe 'GET new' do
        it "generates a new record" do
          get :new
          assigns(:user).should be_instance_of(User)
        end
  end

  context "the user sign up is valid" do
 
    before do
      post :create, user: Fabricate.attributes_for(:user)
    end

      describe 'POST create' do
        it "generates a user from valid data" do
          User.count.should == 1
        end

        it "redirects to sign_in" do
          response.should redirect_to sign_in_path
        end
      end
  end

  context "the user sign up is INVALID" do

    before do
      post :create, user: {email: "", password: "", full_name: ""}
    end

    describe 'POST create' do
        it "generates a user from valid data" do
          User.count.should == 0
        end

        it "renders redirect to sign_in" do
          response.should render_template :new
        end

        it "regenerates a user record for another try" do
          assigns(:user).should be_instance_of(User)
        end
    end
  end

end
