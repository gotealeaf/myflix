require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets @user for new users" do
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end
	end

	describe "POST create" do
		
		context "successful user signup" do
			it "redirects to the sign in page" do
				result = double(:sign_up_result, successful?: true)
				UserSignup.any_instance.should_receive(:sign_up).and_return(result)
				post :create, user: Fabricate.attributes_for(:user)
			  expect(response).to redirect_to sign_in_path
			end
	  end

	  context "failed user sign up" do
	  	it "renders the new template" do
	  		result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
				UserSignup.any_instance.should_receive(:sign_up).and_return(result)
	  		post :create, user: Fabricate.attributes_for(:user), stripeToken: '123123'
	  		expect(response).to render_template :new
	  	end
	  	it "sets the flash error message" do
	  		result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
				UserSignup.any_instance.should_receive(:sign_up).and_return(result)
	  		post :create, user: Fabricate.attributes_for(:user), stripeToken: '123123'
	  		expect(flash[:danger]).to be_present
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

	describe "GET new_with_invitation_token" do

		it "renders the :new view template" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(response).to render_template :new
		end

		it "sets @user with recipient's email" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(assigns(:user).email).to eq(invitation.recipient_email)
		end

		it "sets @invitation_token" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(assigns(:invitation_token)).to eq(invitation.token)
		end

		it "redirects to expired token page for invalid tokens" do
			get :new_with_invitation_token, token: 'asdfasdf'
			expect(response).to redirect_to expired_token_path
		end

	end
end