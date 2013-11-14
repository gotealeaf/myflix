require 'spec_helper'

describe SessionsController do
	describe "GET new" do
		it "renders the new template for unauthenticated users" do
			get :new
			expect(response).to render_template(:new)
		end
		it "redirects to videos for authenticated users" do
			session[:user_id] = Fabricate(:user).id
			get :new
			expect(response).to redirect_to videos_path
		end
	end

	describe "POST create" do
		context "with valid credentials" do
			it "creates a session" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password
				expect(session[:user_id]).to eq(jordan.id)
			end 
			
			it "redirects to the videos path" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password
				expect(response).to redirect_to(videos_path)
			end

			it "sets a welcome notice" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password
				expect(flash[:notice]).not_to be_blank
			end
		end

		context "with invalid credentials"  do
			it "does not put the signed in user into the session" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password + "1"
				expect(session[:user_id]).to be(nil)
			end
			it "gives an error" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password + "1" 
				expect(flash[:error]).to_not be_blank
			end
			it "renders the new template" do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password + "1"
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET destroy" do
		it "clears the session for the user" do
			jordan = Fabricate(:user)
			session[:user_id] = jordan.id
			get :destroy
			expect(session[:user_id]).to be_blank
		end
	end
end