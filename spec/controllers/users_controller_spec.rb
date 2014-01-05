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
			it "creates the user" do
			end
			it "redirects to the sign in page"
	  end
	  context "with invalid input" do
		  it "does not create the user"
	  end
	end
end