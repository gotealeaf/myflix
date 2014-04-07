require 'spec_helper'

describe UserSignup do
    after { ActionMailer::Base.deliveries.clear }
    context "with valid person input and valid credit card input" do
      let(:charge) { double(:charge, successful?: true) }
      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end
      it "creates the user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end
      context "register through invitation" do
        it "should make the user follow the inviter" do
          desmond = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
          UserSignup.new(Fabricate.build(:user, fullname: "linda", email: "linda@123.com", password: "password")).sign_up("some_stripe_token", invitation.token)
          linda = User.find_by(email: "linda@123.com")
          expect(linda.follows?(desmond)).to be_true
        end
        it "should make the inviter follow the user" do
          desmond = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
          UserSignup.new(Fabricate.build(:user, fullname: "linda", email: "linda@123.com", password: "password")).sign_up("some_stripe_token", invitation.token)
          linda = User.find_by(email: "linda@123.com")
          expect(desmond.follows?(linda)).to be_true
        end
        it "should expire the invitation upon acceptance" do
          desmond = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: desmond, recipient_email: "linda@123.com")
          UserSignup.new(Fabricate.build(:user, fullname: "linda", email: "linda@123.com", password: "password")).sign_up("some_stripe_token", invitation.token)
          expect(Invitation.first.token).to be_nil
        end
      end
    end

    context "with invalid person input and valid credit card input" do
      before do
        UserSignup.new(User.new(fullname: 'desmond', password: 'password')).sign_up("some_stripe_token", nil)
      end
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "should not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end
      it "should not send out email with invalid input" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "with valid person input and invalid credit card input" do
      let(:charge) { double(:charge, successful?: false, error_message: 'Your card is declined.') }
      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end
      it "should not create a new user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("1234", nil)
        expect(User.count).to eq(0)
      end
    end

    context "sending emails" do
      let(:charge) { double(:charge, successful?: true) }
      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end
      it "should send out email to user with valid input" do
        UserSignup.new(Fabricate.build(:user, email: "desmond@gmail.com", fullname: "desmond", password: "1234")).sign_up("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(["desmond@gmail.com"])
      end
      it "should send out eamil with user's fullname with valid input" do
        UserSignup.new(Fabricate.build(:user, email: "desmond@gmail.com", fullname: "desmond", password: "1234")).sign_up("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries.last.body).to include("desmond")
      end
    end
end
