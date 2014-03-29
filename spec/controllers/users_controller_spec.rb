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
    after { ActionMailer::Base.deliveries.clear }
    it "sets @user" do
      post :create, user: { fullname: 'desmond', password: 'password'}
      expect(assigns(:user)).to be_instance_of(User)
    end
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to login path if success" do
        expect(response).to redirect_to login_path
      end
    end

    context "register through invitation" do
      it "should make the user follow the inviter" do
        desmond = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
        post :create, user: { fullname: "linda", email: "linda@123.com", password: "password" }, invitation_token: invitation.token
        linda = User.find_by(email: "linda@123.com")
        expect(linda.follows?(desmond)).to be_true
      end
      it "should make the inviter follow the user" do
        desmond = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
        post :create, user: { fullname: "linda", email: "linda@123.com", password: "password" }, invitation_token: invitation.token
        linda = User.find_by(email: "linda@123.com")
        expect(desmond.follows?(linda)).to be_true
      end
      it "should expire the invitation upon acceptance" do
        desmond = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
        post :create, user: { fullname: "linda", email: "linda@123.com", password: "password" }, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end
    end

    context "sending emails" do
      it "should send out email to user with valid input" do
        post :create, user: { email: "desmond@gmail.com", fullname: "desmond", password: "1234" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["desmond@gmail.com"])
      end
      it "should send out eamil with user's fullname with valid input" do
        post :create, user: { email: "desmond@gmail.com", fullname: "desmond", password: "1234" }
        expect(ActionMailer::Base.deliveries.last.body).to include("desmond")
      end
      it "should not send out email with invalid input" do
        post :create, user: { email: "desmond@gmail.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { fullname: 'desmond', password: 'password'}
      end
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders new template if fail" do
        expect(response).to render_template :new
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
