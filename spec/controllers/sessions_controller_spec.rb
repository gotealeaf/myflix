require 'spec_helper'

describe SessionsController do
	describe "GET new" do
		it "renders the new template for unauthenticated users" do
			get :new
			expect(response).to render_template :new
		end

		it "redirects to the home page for authenticated users" do
			session[:user_id] = Fabricate(:user).id
			get :new
			expect(response).to redirect_to home_path
		end
	end

	describe "POST create" do
		context "with valid credentials" do
			
			let(:alice) {Fabricate(:user)}
			
			before do
				post :create, email: alice.email, password: alice.password
			end

			it "puts the signed in user in the sesseion" do
				expect(session[:user_id]).to eq(alice.id)
			end

			it "redirects to the home page" do
				expect(response).to redirect_to home_path
			end

			it "sets the success message" do
				expect(flash[:success]).not_to be_blank
			end
		end

		context "with invalid credentials" do

			before do
				alice = Fabricate(:user)
				post :create, email: alice.email, password: alice.password+"ksdjf"
			end

			it "doesn't put the siged in user in the session" do
				expect(session[:user_id]).to be_nil
			end

			it "render :new template" do
				expect(response).to render_template :new
			end

			it "sets the danger message" do
				expect(flash[:danger]).not_to be_blank
			end
		end
	end

	describe "GET destroy" do

		before do
			session[:user_id] = Fabricate(:user).id
			get :destroy
		end

		it "clears the session for the user" do
			expect(session[:user_id]).to be_nil
		end

		it "redirects to the root path" do
			expect(:response).to redirect_to root_path
		end

		it "sets the warning message" do
			expect(flash[:warning]).not_to be_blank
		end
	end
end
