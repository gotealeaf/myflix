require "spec_helper"

describe UserSignUp do
  describe '#user_sign_up' do
    context "with valid input and valid card" do
      before do
        customer = double(:customer, successful?: true)
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
      end
      it "creates a new user" do
        UserSignUp.new(Fabricate.build(:user), "12345", nil).user_sign_up
        expect(User.count).to eq(1)
      end
      it "should make sure that the new user follows the person who invited him if a token is present" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        UserSignUp.new(Fabricate.build(:user), "12345", friend.token).user_sign_up
        expect(User.last.following?(joe)).to eq(true)
      end
      it "should make sure that the person who invited the new user follows him if a token is present" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        UserSignUp.new(Fabricate.build(:user), "12345", friend.token).user_sign_up
        expect(joe.following?(User.last)).to eq(true)
      end
      it "expires the invitation upon acceptance" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        UserSignUp.new(Fabricate.build(:user), "12345", friend.token).user_sign_up
        expect(friend.reload.token).to eq(nil)
      end
    end
    context "with valid input and declined card" do
      before do
        customer = double(:customer, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
      end
      it "does not create a user record" do
        UserSignUp.new(Fabricate.build(:user), "12345", nil).user_sign_up
        expect(User.count).to eq(0)
      end
      it "checks to verify that an error message has been created" do
        signup = UserSignUp.new(Fabricate.build(:user), "12345", nil).user_sign_up
        expect(signup.error_message).to eq("Your card was declined.")
      end
    end
    context "with invalid input" do
      it "does not create a new user" do
        UserSignUp.new(Fabricate.build(:user, full_name: ""), "12345", nil).user_sign_up
        expect(User.count).to eq(0)
      end
      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
        UserSignUp.new(Fabricate.build(:user, full_name: ""), "12345", nil).user_sign_up
      end
      it "does not send an email if the user record is invalid" do
        ActionMailer::Base.deliveries.clear
        UserSignUp.new(Fabricate.build(:user, full_name: ""), "12345", nil).user_sign_up
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
    context "email sending" do
      before do
        customer = double(:customer, successful?: true)
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
        ActionMailer::Base.deliveries.clear
      end
      it "sends out the email" do
        UserSignUp.new(Fabricate.build(:user), "12345", nil).user_sign_up
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it "sends to the right recipient" do
        UserSignUp.new(Fabricate.build(:user, email: "alice@example.com"), "12345", nil).user_sign_up
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["alice@example.com"])
      end
      it "has the right content" do
        UserSignUp.new(Fabricate.build(:user, full_name: "Alice Humperdink"), "12345", nil).user_sign_up
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Alice Humperdink')
      end
    end
  end
end