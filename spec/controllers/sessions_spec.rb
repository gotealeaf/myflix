require 'spec_helper'

describe SessionsController do

	describe "GET new" do
		it "should redirect_to if logged in" do
			user = Fabricate(:user)
			session[:user_id] = "1"
			get :new
			expect(response).to redirect_to home_path
		end
	end

	describe "POST create" do
		context "user authenticates correctly" do
			before do
	   		   user = Fabricate(:user)
			   post :create, email: user.email, password: user.password
			end

			it "should set session[:user_id]" do	
			   expect(session[:user_id]).to eq(1)
			end

			it "Should redirect to home_path" do	 
			   expect(response).to redirect_to home_path
			end

			it "sets the flash notice not to be blank" do
				expect(flash[:success]).not_to be_blank
			end
		end

		context "user does not authenticate" do
			before do
			   user = Fabricate(:user)
			   post :create, email: user.email, password: "asdasd"
			end

			it "sets session id to empty" do
			   expect(session[:user_id]).to be_nil
			end

			it "sets the flash error not to be blank" do
				expect(flash[:error]).not_to be_blank
			end

			it "should render new" do
			   expect(response).to render_template(:new)
			end

		end
	end

	describe "GET destroy" do
		before do
			session[:user_id] = Fabricate(:user).id
			get :destroy
		end

		it "should set session id to blank" do
	
			expect(session[:user_id]).to be_blank
		end

		it "should set flash notice" do
			expect(flash[:notice]).not_to be_blank
		end

		it "should redirect to root_path" do
			expect(response).to redirect_to root_path
		end
	end
end

=begin
class SessionsController < ApplicationController
	def new
		redirect_to home_path if logged_in?
	end

	def create
		user = User.find_by email: params[:email]
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in" 
			redirect_to home_path
		else
			flash[:error] = "Something wrong with your username or password"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = ""
		flash[:notice] = "You have logged out"
		redirect_to root_path
	end
end
=end