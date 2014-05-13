require 'spec_helper'

describe UserSignup do 
  describe "#sign_up" do
    context "valid personal info and valid card" do
      let(:charge) { double(:charge, successful?: true)}

      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      around(:each) { ActionMailer::Base.deliveries.clear } 

      it "creates the user" do
        UserSignup.new(Fabricate.attributes_for(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      context "and registering with a token" do
        it "makes the guest follow the invitor" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com", password: "password", full_name: "alice smith")).sign_up("some_stripe_token", invitation.invitation_token)

          alice = User.where(email: "alice@example.com").first
          expect(alice.following?(bob)).to be_true
        end
        it "makes the inviter follow the guest" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com", password: "password", full_name: "alice smith")).sign_up("some_stripe_token", invitation.invitation_token)

          alice = User.where(email: "alice@example.com").first
          expect(bob.following?(alice)).to be_true
        end

        it "expires the invitation upon acceptance" do
          bob = Fabricate(:user)
          invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
          invitation_token = invitation.invitation_token
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com", password: "password", full_name: "alice smith")).sign_up("some_stripe_token", invitation.invitation_token)

          expect(invitation.reload.invitation_token).not_to eq(invitation_token)
        end
      end

      context "and while email sending" do
        it "sends out the email about registration" do
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com")).sign_up("some_stripe_token", nil)
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end
        it "sends to the right recipient" do
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com")).sign_up("some_stripe_token", nil)
          message = ActionMailer::Base.deliveries

          expect(message.last.to).to eq([User.last.email])
        end
        it "has the right content" do
          UserSignup.new(Fabricate.build(:user, email: "alice@example.com")).sign_up("some_stripe_token", nil)
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("You created an account on MyFLiX with")
        end
      end
    end

    context "with valid personal info and declined card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined")
        allow(StripeWrapper::Charge).to receive(:create) {charge}
        UserSignup.new(Fabricate.build(:user)).sign_up('12345', nil)

        expect(User.count).to eq(0)
      end
    end

    context "with invalid personal info" do
      it "does not create a record when input is invalid " do
        UserSignup.new(User.new(email: "bob@example.com")).sign_up('some_token', nil)
        expect(User.count).to eq(0)
      end

      it "does not charge the card" do
        UserSignup.new(User.new(email: "bob@example.com")).sign_up('some_token', nil)
        StripeWrapper::Charge.should_not_receive(:create)
      end

      it "does not send out an email with invalid inputs" do
        UserSignup.new(User.new(email: "bob@example.com")).sign_up('some_token', nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end