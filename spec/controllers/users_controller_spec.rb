require 'spec_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if the user is inauthenticated" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET index" do
    it "shows all of the current user's followed users" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      get :index
      expect(alice.followed_users).to eq([bob])
    end
  end

  describe "GET show" do
    it "shows the user's queued videos" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: south_park, user: alice)

      get :show, id: alice.id
      expect(alice.queue_items).to eq([queue_item])
    end
    it "shows the user's reviews" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      review =  Fabricate(:review, rating: 3, user: alice, video: south_park )

      get :show, id: alice.id
      expect(alice.reviews).to eq([review])
    end
  end

  describe "POST create" do
    context "with valid personal info and valid card" do
      
      let(:charge) { double(:charge, successful?: true)}

      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      it "creates the user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "redirects to the videos path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to videos_path
      end

      context "and registering with a token" do
        it "makes the guest follow the invitor" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          post :create, user: {email: "alice@example.com", password: "password", full_name: "alice smith"}, token: invitation.token

          alice = User.where(email: "alice@example.com").first
          expect(alice.following?(bob)).to be_true
        end
        it "makes the inviter follow the guest" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          post :create, user: {email: "alice@example.com", password: "password", full_name: "alice smith"}, token: invitation.token

          alice = User.where(email: "alice@example.com").first
          expect(bob.following?(alice)).to be_true
        end

        it "expires the invitation upon acceptance" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          invitation_token = invitation.token
          post :create, user: {email: "alice@example.com", password: "password", full_name: "alice smith"}, token: invitation.token

          expect(invitation.reload.token).not_to eq(invitation_token)
        end
      end

      context "and while email sending" do
        it "sends out the email about registration" do
          post :create, user: Fabricate.attributes_for(:user)
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end
        it "sends to the right recipient" do
          post :create, user: Fabricate.attributes_for(:user)
          message = ActionMailer::Base.deliveries

          expect(message.last.to).to eq([User.last.email])
        end
        it "has the right content" do
          post :create, user: Fabricate.attributes_for(:user)
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("You created an account on MyFLiX with")
        end
      end
    end

    context "with valid personal info and declined card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined")
        allow(StripeWrapper::Charge).to receive(:create) {charge}
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'

        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'

        expect(response).to render_template(:new)
      end
      it "sets the flash error message" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'

        expect(flash[:error]).to be_present
      end
    end
    context "with invalid personal info" do

      around(:each) { ActionMailer::Base.deliveries.clear } 
      
      before do
        post :create, user: { full_name: "jane" }
      end

      it "does not create a record when input is invalid " do
        expect(User.count).to eq(0)
      end

      it "renders new template when input is invalid" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
        post :create, user: { email: "alice@example.com"}
      end

      it "does not send out an email with invalid inputs" do
        post :create, user: { email: "alice@example.com"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET register_with_token" do 
    it "renders the :new view template" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, token: invitation.token

      expect(response).to render_template(:new)
    end

    it "sets @user with recipients email" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, token: invitation.token

      expect(assigns(:user).email).to eq("alice@example.com")
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :register_with_token, token: invitation.token

      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, token: '12345'

      expect(response).to redirect_to(expired_token_path)
    end
  end
end

