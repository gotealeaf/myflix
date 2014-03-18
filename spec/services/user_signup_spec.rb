require 'spec_helper'

describe UserSignup do
	describe "#sign_up" do
		context "with valid personal info and valid card" do

			let(:customer) { double(:customer, successful?: true, customer_token: "abcdefg") }
			before do
				StripeWrapper::Customer.should_receive(:create).and_return(customer)
			end

			after { ActionMailer::Base.deliveries.clear }

			it "creates the user" do
				UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
				expect(User.count).to eq(1)
			end

			it "stores the customer token from stripe" do
				UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
				expect(User.first.customer_token).to eq("abcdefg")
			end

			it "makes the user follow the inviter" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Johnson')).sign_up("some_stripe_token", invitation.token)
				joe = User.where(email: 'joe@example.com').first
				expect(joe.follows?(alice)).to be_true
			end

			it "makes the inviter follow the user" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Johnson')).sign_up("some_stripe_token", invitation.token)
				joe = User.where(email: 'joe@example.com').first
				expect(alice.follows?(joe)).to be_true
			end

			it "expires the invitation upon the acceptance" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Johnson')).sign_up("some_stripe_token", invitation.token)
				expect(Invitation.first.token).to be_nil
			end

			it "sends out email to the user with valid inputs" do
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com')).sign_up("some_stripe_token", nil)
				expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
			end

			it "sends out email containing the user's name with valid inputs" do
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', full_name: 'Joe Johnson')).sign_up("some_stripe_token", nil)
				expect(ActionMailer::Base.deliveries.last.body).to include("Joe Johnson")
			end
		end

		context "valid personal info and declined card" do
			it "doesn't create a new user record" do
				customer = double(:customer, successful?: false, error_message: "Your card was declined.")
				StripeWrapper::Customer.should_receive(:create).and_return(customer)
				UserSignup.new(Fabricate.build(:user)).sign_up('12345', nil)
				expect(User.count).to eq(0)
			end
		end

		context "with invalid personal info" do
			it "doesn't create the user" do
				UserSignup.new(User.new(email: 'alice@example.com')).sign_up('12345', nil)				
				expect(User.count).to eq(0)
			end

			it "doesn't charge the card" do
				StripeWrapper::Customer.should_not_receive(:create)
				UserSignup.new(User.new(email: 'alice@example.com')).sign_up('12345', nil)				
			end

			it "doesn't send out email with invalid inputs" do
				UserSignup.new(User.new(email: 'alice@example.com')).sign_up('12345', nil)				
				expect(ActionMailer::Base.deliveries).to be_empty
			end
		end
	end
end
