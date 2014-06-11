require 'spec_helper'

describe UserSignUp do
  describe "#sign_up" do
    context "valid personal info and valid credit card" do
      
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(true)
        customer.stub(:customer_token).and_return('12345')
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
      end
      
      after do 
        ActionMailer::Base.deliveries.clear 
      end #this will clear the queue after each run. We have to specify this because ActionMailer is not part of database transactions, so it will not automatically roll back
      
      it "creates a new user" do
        UserSignUp.new(Fabricate.build(:user)).sign_up('stripeToken', nil)
        expect(User.count).to eq(1) 
      end
      
      it 'stores the customer token from stripe' do
        UserSignUp.new(Fabricate.build(:user)).sign_up('stripeToken', nil)
        expect(User.first.customer_token).to eq('12345')
      end
      
      it "makes the user follow the inviter" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        UserSignUp.new(Fabricate.build(:user, email: "joe@example.com", full_name: "Joe Bloggs", password: "password")).sign_up('stripeToken', invitation.token)
        joe = User.where(email: "joe@example.com").first
        expect(joe.follows?(jane)).to be_true
      end
      
      it "makes the inviter follow the user" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        UserSignUp.new(Fabricate.build(:user, email: "joe@example.com", full_name: "Joe Bloggs", password: "password")).sign_up('stripeToken', invitation.token)
        joe = User.where(email: "joe@example.com").first
        expect(jane.follows?(joe)).to be_true
      end
      
      it "expires the token upon acceptance" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        UserSignUp.new(Fabricate.build(:user, email: "joe@example.com", full_name: "Joe Bloggs", password: "password")).sign_up('stripeToken', invitation.token)
        joe = User.where(email: "joe@example.com").first
        expect(Invitation.first.token).to be_nil
      end
      
      it 'should send email to the right recipient if input was valid' do
        UserSignUp.new(Fabricate.build(:user, email: "joe@example.com", full_name: "Joe Bloggs", password: "password")).sign_up('stripeToken', nil)
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["joe@example.com"])
      end
      
      it 'should send email with the right content if input was valid' do
        UserSignUp.new(Fabricate.build(:user, email: "joe@example.com", full_name: "Joe Bloggs", password: "password")).sign_up('stripeToken', nil)
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Joe Bloggs')
      end
    end #ends context valid personal info and valid credit card
    
    context "with valid personal info but card declined" do
      
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(false)
        customer.stub(:error_message).and_return('Your card was declined.')
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
        #post :create, user: Fabricate.attributes_for(:user)
      end
      
      it "does not create a new user record" do
        UserSignUp.new(Fabricate.build(:user)).sign_up('stripeToken', nil)
        expect(User.count).to eq(0)
      end
    end #ends context valid personal info but declined card
    
    context "with invalid personal info input" do
      
      after do 
        ActionMailer::Base.deliveries.clear 
      end
      
      it "does not create a user" do
        UserSignUp.new(User.new(email: "user@example.com")).sign_up('stripeToken', nil)
        expect(User.count).to eq(0)
      end
      
      it 'should not send out email if input was invalid' do
        UserSignUp.new(User.new(email: "user@example.com")).sign_up('stripeToken', nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      
      it "does not attempt to charge to charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create) #verifying the communication between the user's controller and the stripe wrapper
        UserSignUp.new(User.new(email: "user@example.com", password: "password")).sign_up('stripeToken', nil)
      end 
    end # ends context with invalid input
  end #ends describe sign up
end