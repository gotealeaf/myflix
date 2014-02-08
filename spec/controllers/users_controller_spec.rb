require 'spec_helper'


describe UsersController, sidekiq: :inline do

  describe "GET new" do
    it "sets the @user variable" do
      user = Fabricate(:user)
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "GET new_with_invitation_token" do
    context "with a valid invite" do
      let!(:invite) {Fabricate(:invitation)}
      before { get :new_with_invitation_token, token: invite.token}
      it "should render the new template" do
         expect(response).to render_template :new
      end
      it "should prefill the address" do
        expect(assigns(:user).email).to eq(invite.recipient_email)
      end
      it "should set the token" do
        expect(assigns(:invitation_token)).to eq(invite.token)
      end
    end
    context "with invalid token" do
      it "should redirect to the expired  token page" do
        get :new_with_invitation_token, token: '987asd98sad7f'
         expect(response).to redirect_to failed_token_path
      end
    end
  end

  describe "POST create" do
after {ActionMailer::Base.deliveries.clear}

    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user)}

      it "creates a user " do
        expect(User.count).to eq(1)
      end
      it "should  sign in the new user" do
        expect(session[:user_id]).to eq(User.first.id) 
      end
      it "should redirect to home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with an invitation" do

      it "makes user follower inviter" do
        inviter = Fabricate(:user)
        invite = Fabricate(:invitation, inviter_id: inviter.id)
        user_attributes = Fabricate.attributes_for(:user, email: invite.recipient_email)
        post :create, user: user_attributes, invitation_token: invite.token
        friend = User.where(email: invite.recipient_email).first
        expect(friend.follows?(inviter)).to be_true

      end
      it "makes the inviter follow the user" do
        inviter = Fabricate(:user)
        invite = Fabricate(:invitation, inviter_id: inviter.id)
        user_attributes = Fabricate.attributes_for(:user, email: invite.recipient_email)
        post :create, user: user_attributes, invitation_token: invite.token
        friend = User.where(email: invite.recipient_email).first
        expect(inviter.follows?(friend)).to be_true
      end
      it "resets the invitation token" do
        inviter = Fabricate(:user)
        invite = Fabricate(:invitation, inviter_id: inviter.id)
        user_attributes = Fabricate.attributes_for(:user, email: invite.recipient_email)
        post :create, user: user_attributes, invitation_token: invite.token
        friend = User.where(email: invite.recipient_email).first
        expect(Invitation.first.token).to be_nil
        # or expect(invite.reload.token).to be_nil
      end
    end

    context "email sending" do
  
      it "sends out the email" do
        post :create, user: Fabricate.attributes_for(:user)
        ActionMailer::Base.deliveries.should_not be_empty
      end
      it"sends to the right recipient" do
        post :create, user: Fabricate.attributes_for(:user, email: 'me@them.com')
        message = ActionMailer::Base.deliveries.last
        message.to.should == ['me@them.com']
      end
      it "has the user name in the body" do
        post :create, user: Fabricate.attributes_for(:user, full_name: 'Victory')
        message = ActionMailer::Base.deliveries.last
        message.body.should include('Victory')
      end
      it "doesn't send with invalid inputs" do
        post :create, user: {email: 'me@them.com'}
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        expect(ActionMailer::Base.deliveries).to be_empty
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