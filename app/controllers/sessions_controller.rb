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