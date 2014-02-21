require 'spec_helper'

describe UserSignup do
	describe "#sign_up" do
		context "valid personal info and valid card" do
			let(:customer) { double(:customer, successful?: true, customer_token: "abcdefg") }
			before do 
				StripeWrapper::Customer.should_receive(:create).at_least(1).times.and_return(customer)
			end
			after { ActionMailer::Base.deliveries.clear }

			it "creates the user" do
				UserSignup.new(Fabricate.build(:user)).sign_up("123", nil)
				expect(User.count).to eq(1)
			end

			it "stores the customer token from stripe" do
				UserSignup.new(Fabricate.build(:user)).sign_up("123", nil)
				expect(User.first.customer_token).to eq("abcdefg")
			end

			it "makes the user follow the inviter" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("123", invitation.token)
				joe = User.find_by(email: "joe@example.com")
				expect(joe.follows?(alice)).to be_true
			end

			it "makes the inviter follow the user" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("123", invitation.token)
				joe = User.find_by(email: "joe@example.com")
				expect(alice.follows?(joe)).to be_true
			end

			it "expires the invitation upon acceptance" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("123", invitation.token)
				expect(Invitation.first.token).to be_nil
			end

			it "sends out an email to the user with valid inputs" do
				UserSignup.new(Fabricate.build(:user, email: "jack@example.com")).sign_up("123", nil)
	  		expect(ActionMailer::Base.deliveries.last.to).to eq(['jack@example.com'])
	  	end

	  	it "sends out an email containing the user's name with valid inputs" do
	  		UserSignup.new(Fabricate.build(:user, email: "jack@example.com", full_name: "Jack Collins")).sign_up("123", nil)
	  		expect(ActionMailer::Base.deliveries.last.body).to include("Jack Collins")
	  	end
		end

		context "valid personal info and declined card" do
	  	it "does not create a new user record" do
	  		customer = double(:customer, successful?: false, error_message: "Your card was declined.")
	  		StripeWrapper::Customer.should_receive(:create).and_return(customer)
	  		UserSignup.new(Fabricate.build(:user)).sign_up("123123", nil)
	  		expect(User.count).to eq(0)
	  	end
	  end

	  context "with invalid personal info" do
	  	 
	  	before { UserSignup.new(User.new(email: "jack@example.com")).sign_up("123123", nil) }

		  it "does not create the user" do
		  	expect(User.count).to eq(0)
		  end

		  it "does not charge the card" do
		  	StripeWrapper::Customer.should_not_receive(:customer)
		  end

		  it "does not send out an email with invalid inputs" do
	  		expect(ActionMailer::Base.deliveries).to be_empty
	  	end
	  end
	end
end