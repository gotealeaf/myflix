require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user to User.new" do
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET new_with_invitation_token" do
    context "valid token" do
      it "sets @user with attributes from the invitation" do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(assigns(:user).full_name).to eq(invitation.recipient_name)
        expect(assigns(:user).email).to eq(invitation.recipient_email)
      end

      it "renders the registration page" do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(response).to render_template :new
      end

      it "sets @invitation_token to the invitation's token" do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(assigns(:invitation_token)).to eq(invitation.token)
      end
    end

    context "invalid token" do 
      it "redirects to expired token path" do 
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: "bad_token"
        expect(response).to redirect_to expired_token_path
      end
    end
  end

  describe "POST create" do
    context "personal information is valid" do
      context "card is valid" do
        around { ActionMailer::Base.deliveries.clear }
        before do
          charge = double(:charge, successful?: true)
          StripeWrapper::Charge.should_receive(:create).and_return(charge)
        end

        it "creates a new user" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(assigns(:user)).to be_instance_of(User)
          expect(assigns(:user).save).to be_true
        end

        it "sends out a welcome email" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end

        it "sends the welcome email to the right recipient" do
          post :create, user: Fabricate.attributes_for(:user)
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([User.first.email])
        end

        it "sends a welcome email with the right content" do
          post :create, user: Fabricate.attributes_for(:user)
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("Welcome to MyFlix, #{User.first.full_name}!")
        end

        it "makes the user follow the inviter, if invited" do
          alice = Fabricate(:user)
          bob = Fabricate.build(:user)
          invitation = Fabricate(:invitation,
                                 recipient_email: bob.email,
                                 recipient_name: bob.full_name,
                                 inviter_id: alice.id)
          (post :create, 
            invitation_token: invitation.token, 
            user: Fabricate.attributes_for(:user, 
                                           email: invitation.recipient_email, 
                                           full_name: invitation.recipient_name))
          bob = User.find_by(email: bob.email)
          expect(bob.follows?(alice)).to be_true
        end 

        it "makes the inviter follow the user, if invited" do 
          alice = Fabricate(:user)
          bob = Fabricate.build(:user)
          invitation = Fabricate(:invitation,
                                 recipient_email: bob.email,
                                 recipient_name: bob.full_name,
                                 inviter_id: alice.id)
          (post :create, 
            invitation_token: invitation.token, 
            user: Fabricate.attributes_for(:user, 
                                           email: invitation.recipient_email, 
                                           full_name: invitation.recipient_name))
          bob = User.find_by(email: bob.email)
          expect(alice.follows?(bob)).to be_true
        end

        it "expires the invitation" do
          alice = Fabricate(:user)
          bob = Fabricate.build(:user)
          invitation = Fabricate(:invitation,
                                 recipient_email: bob.email,
                                 recipient_name: bob.full_name,
                                 inviter_id: alice.id)
          (post :create, 
            invitation_token: invitation.token, 
            user: Fabricate.attributes_for(:user, 
                                           email: invitation.recipient_email, 
                                           full_name: invitation.recipient_name))
          expect(invitation.reload.token).to be_nil
        end

        it "redirects to login page" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(response).to redirect_to login_path
        end
      end

      context "card is not valid" do
        before do
          charge = double(:charge, 
                          successful?: false, 
                          error_message: "Your card was declined.")
          StripeWrapper::Charge.should_receive(:create).and_return(charge)
        end

        it "does not create a new user" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(assigns(:user)).to be_valid
          expect(User.count).to eq(0)
        end

        it "does not send a welcome email" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(ActionMailer::Base.deliveries).to be_empty
        end

        it "sets a flash danger message with the card error message" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(flash[:danger]).to eq("Your card was declined.")
        end

        it "renders :new template if no invitation" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(response).to render_template(:new)
        end
      end
    end

    context "personal information is not valid" do
      before { post :create, user: Fabricate.attributes_for(:user, password: "") }
      
      it "does not save the user" do
        expect(assigns(:user)).to_not be_valid
        expect(assigns(:user).save).to be_false
        expect(User.count).to eq(0)
      end

      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "does not send an email" do
        post :create, user: { email: 'baduser@example.com' }
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    before do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
    end

    it "sets @user" do
      set_current_user(User.find(1))
      get :show, id: User.find(2).id 
      expect(assigns(:user)).to be_instance_of(User)
    end

    context "unauthenticated user" do
      before { get :show, id: User.find(2).id }

      it "does not set @user" do
        expect(assigns(:user)).not_to be_instance_of(User)
      end

      it_behaves_like "requires login" do
        let(:action) { get :show, id: User.find(2).id }   
      end
    end
  end
end