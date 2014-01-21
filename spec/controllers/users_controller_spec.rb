require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets @user for new users" do
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end
	end

	describe "POST create" do
		
		context "with valid input" do

			before { post :create, user: Fabricate.attributes_for(:user) }

			it "creates the user" do
				expect(User.count).to eq(1)
			end

			it "redirects to the sign in page" do
			  expect(response).to redirect_to sign_in_path
			end
	  end

	  context "with invalid input" do
	  	 
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
	  end

	  context "sending emails" do 
	  	after { ActionMailer::Base.deliveries.clear }

	  	it "sends out an email to the user with valid inputs" do
	  		post :create, user: { email: "jack@example.com", password: "password", full_name: "Jack Collins" }
	  		expect(ActionMailer::Base.deliveries.last.to).to eq(['jack@example.com'])
	  	end

	  	it "sends out an email containing the user's name with valid inputs" do
	  		post :create, user: { email: "jack@example.com", password: "password", full_name: "Jack Collins" }
	  		expect(ActionMailer::Base.deliveries.last.body).to include("Jack Collins")
	  	end

	  	it "does not send out an email with invalid inputs" do
	  		post :create, user: { email: "jack@example.com" }
	  		expect(ActionMailer::Base.deliveries).to be_empty
	  	end
	  end

	end

	describe "GET show" do
		it_behaves_like "requires sign in" do
			let(:action) { get :show, id: 3 }
		end

		it "sets @user for the clicked user" do
			set_current_user
			alice = Fabricate(:user)
			get :show, id: alice.id
			expect(assigns(:user)).to eq(alice)
		end
	end
end