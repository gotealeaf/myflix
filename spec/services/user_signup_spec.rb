require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "valid personal ifno and valid card" do

      let(:charge) { double(:charge, successful?: true) }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }
      after { ActionMailer::Base.deliveries.clear }

      it "creates the user" do
        UserSignup.new(Fabricate.build :user, email: "paq@paq.com", full_name: "paquito_spec").sign_up "stripe_token", nil

        User.first.email.should == "paq@paq.com"
        User.first.full_name.should == "paquito_spec"
      end

      it "creates a bidirectional relationship between the user and the invited user" do
        ana = Fabricate :user
        invitation = Fabricate :invitation, inviter: ana, recipient_email: "paq@paq.com"

        UserSignup.new(Fabricate.build :user, email: invitation.recipient_email, full_name: invitation.recipient_name, password: "password", password_confirmation: "password").sign_up "stripe_token", invitation.token
      
        expect(ana.follows? User.last).to be_true
        expect(User.last.follows? ana).to be_true
      end

      it "expires the token" do
        ana = Fabricate :user
        invitation = Fabricate :invitation, inviter: ana, recipient_email: "paq@paq.com"

        UserSignup.new(Fabricate.build :user, email: invitation.recipient_email, full_name: invitation.recipient_name, password: "password", password_confirmation: "password").sign_up "stripe_token", invitation.token        
      
        expect(Invitation.last.token).to be_nil
      end   

      it "sends out the email" do
        UserSignup.new(Fabricate.build :user, email: "paq@paq.com", full_name: "paquito_spec").sign_up "stripe_token", nil
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the right recipient" do
        UserSignup.new(Fabricate.build :user, email: "paq@paq.com", full_name: "paquito_spec").sign_up "stripe_token", nil
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["paq@paq.com"])
      end

      it "has the right content" do
       UserSignup.new(Fabricate.build :user, email: "paq@paq.com", full_name: "paquito_spec").sign_up "stripe_token", nil
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to Myflix paquito_spec!")
      end          
    end

    context "valid personal info and declined card" do
      let(:charge) { double(:charge, successful?: false, error_message: "Your card was declined") }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }

      it "does not create a new user record" do
        UserSignup.new(Fabricate.build :user, email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password").sign_up "stripe_token", nil  
        expect(User.count).to eq(0)
      end
    end   
    
    context "with invalid personal info" do
      before { UserSignup.new(User.new(full_name: "paquito_spec")).sign_up "stripe_token", nil }
      after { ActionMailer::Base.deliveries.clear }

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "does not send an email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end
    end     
  end
end