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
			before do
				@jordan = Fabricate(:user)
				post :create, email: @jordan.email, password: @jordan.password
			end

			it "creates a session" do
				expect(session[:user_id]).to eq(@jordan.id)
			end 
			
			it "redirects to the videos path" do
				expect(response).to redirect_to(videos_path)
			end

			it "sets a welcome notice" do
				expect(flash[:notice]).not_to be_blank
			end
		end

		context "with invalid credentials"  do
			before do
				jordan = Fabricate(:user)
				post :create, email: jordan.email, password: jordan.password + "1"
			end
			it "does not put the signed in user into the session" do
				expect(session[:user_id]).to be(nil)
			end
			it "gives an error" do
				expect(flash[:error]).to_not be_blank
			end
			it "renders the new template" do
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET destroy" do
		before do
			session[:user_id] = Fabricate(:user).id
		end
		it "clears the session for the user" do
			get :destroy
			expect(session[:user_id]).to be_blank
		end
		
		it "redirects to root path" do
			get :destroy
			expect(response).to redirect_to root_path
		end

		it "sets the notice" do
			get :destroy
			expect(:notice).to_not be_blank
		end
	end
end