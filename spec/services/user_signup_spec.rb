require 'spec_helper'

describe UserSignup do
	describe "#sign_up" do
		context "valid personal info and valid card" do
			let(:charge) { double(:charge, successful?: true) }
			before do 
				StripeWrapper::Charge.should_receive(:create).at_least(1).times.and_return(charge)
			end
			after { ActionMailer::Base.deliveries.clear }

			it "creates the user" do
				UserSignup.new(Fabricate.build(:user)).sign_up(["123", "123"])
				expect(User.count).to eq(1)
			end

			it "makes the user follow the inviter" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				post :create, user: {email: 'joe@example.com', password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
				joe = User.find_by(email: "joe@example.com")
				expect(joe.follows?(alice)).to be_true
			end

			it "makes the inviter follow the user" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				post :create, user: {email: 'joe@example.com', password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
				joe = User.find_by(email: "joe@example.com")
				expect(alice.follows?(joe)).to be_true
			end

			it "expires the invitation upon acceptance" do
				alice = Fabricate(:user)
				invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
				post :create, user: {email: 'joe@example.com', password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
				expect(Invitation.first.token).to be_nil
			end

			it "sends out an email to the user with valid inputs" do
	  		post :create, user: { email: "jack@example.com", password: "password", full_name: "Jack Collins" }
	  		expect(ActionMailer::Base.deliveries.last.to).to eq(['jack@example.com'])
	  	end

	  	it "sends out an email containing the user's name with valid inputs" do
	  		post :create, user: { email: "jack@example.com", password: "password", full_name: "Jack Collins" }
	  		expect(ActionMailer::Base.deliveries.last.body).to include("Jack Collins")
	  	end
		end

		context "valid personal info and declined card" do
	  	it "does not create a new user record" do
	  		charge = double(:charge, successful?: false, error_message: "Your card was declined.")
	  		StripeWrapper::Charge.should_receive(:create).and_return(charge)
	  		post :create, user: Fabricate.attributes_for(:user), stripeToken: '123123'
	  		expect(User.count).to eq(0)
	  	end
	  end

	  context "with invalid personal info" do
	  	 
	  	before { post :create, user: { password: "password", full_name: "Kevin Smith" } }

		  it "does not create the user" do
		  	expect(User.count).to eq(0)
		  end

		  it "renders the :new template" do
		  	expect(response).to render_template :new
		  end

		  it "sets @user" do 
		  	expect(assigns(:user)).to be_instance_of(User)
		  end

		  it "does not charge the card" do
		  	StripeWrapper::Charge.should_not_receive(:create)
		  	post :create, user: { email: "kevin@example.com" }
		  end

		  it "does not send out an email with invalid inputs" do
	  		post :create, user: { email: "jack@example.com" }
	  		expect(ActionMailer::Base.deliveries).to be_empty
	  	end
	  end
	end
end