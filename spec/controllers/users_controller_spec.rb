require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do
    it "sets @user" do
      post :create, user: { fullname: 'desmond', password: 'password'}
      expect(assigns(:user)).to be_instance_of(User)
    end
    context "successful user signup" do
      it "redirects to login path if success" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to login_path
      end
    end

    context "failed user signup" do
      it "renders new template if fail" do
        result = double(:sign_up_result, successful?: false, error_message: 'This is an error message')
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: { fullname: 'desmond', password: 'password'}
        expect(response).to render_template :new
      end
      it "should set danger message" do
        result = double(:sign_up_result, successful?: false, error_message: 'This is an error message')
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: { fullname: 'desmond', password: 'password'}
        expect(flash[:danger]).to eq('This is an error message')
      end
    end
  end

  describe "GET show" do
    context "with authenticated users" do
      it "should set the user variable" do
        desmond = Fabricate(:user)
        set_current_user
        get :show, id: desmond.id
        expect(assigns(:user)).to eq(desmond)
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :show, id: 3 }
      end
    end
  end

  describe "GET new_with_invitation_token" do
    it "should render the new template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it "should set @user with recipient email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    it "should set @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it "should redirect to expired token page if token is invalid" do
      get :new_with_invitation_token, token: "1234"
      expect(response).to redirect_to expired_token_path
    end
  end
end
