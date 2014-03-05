require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "creates a new User object" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "should render the Register page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET new_with_token' do
    it "should render the Register page" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(response).to render_template :new
    end
    it "should populate the form's fields with the user name and email address" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(assigns(:user).email).to eq(friend.email)
      expect(assigns(:user).full_name).to eq(friend.full_name)
    end
    it "should set the @token instance variable" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(assigns(:token)).to eq(friend.token)
    end
    it "should redirect the user to the Expired Token page if the token is invalid" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe 'GET show' do
    it "should have a user object" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.token
      expect(assigns(:user)).to eq(user)
    end
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: 1 }
    end
  end

  describe 'POST create' do
    context "with valid input" do
      before do
        sign_up = double(:sign_up, successful?: true, user: Fabricate(:user))
        expect_any_instance_of(UserSignUp).to receive(:user_sign_up).and_return(sign_up)
      end
      it "redirects to the root" do
        create_user_valid_credentials
        expect(response).to redirect_to root_path
      end
      it "creates a new session" do
        create_user_valid_credentials
        expect(session[:user_id]).not_to eq nil
      end
      it "sets a success message" do
        create_user_valid_credentials
        expect(flash[:success]).to eq("Thanks for becoming a member of MyFLix!")
      end
    end
    context "with invalid input" do
      before do
        sign_up = double(:sign_up, successful?: false, error_message: "There is something wrong with your input.")
        expect_any_instance_of(UserSignUp).to receive(:user_sign_up).and_return(sign_up)
      end
      it "returns a flash error message" do
        create_user_invalid_credentials
        expect(flash[:error]).to eq("There is something wrong with your input.")
      end
      it "renders the new template" do
        create_user_invalid_credentials
        expect(response).to render_template :new
      end
    end
  end

  private

  def create_user_valid_credentials
    post :create, user: Fabricate.attributes_for(:user)
  end

  def create_user_invalid_credentials
    post :create, user: { password: 'joelevinger', full_name: 'Joe Levinger' }
  end
end