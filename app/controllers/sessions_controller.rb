class SessionsController < ApplicationController
	def new
		redirect_to home_path if current_user
	end

	def create
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			if user.active?
				session[:user_id] = user.id
				flash[:success] = "You've signed in, enjoy!"
				redirect_to home_path
			else
				flash[:danger] = "Your account has been suspended, please contact customer service."
				redirect_to sign_in_path
			end
		else
			flash[:danger] = "Invalid email or password."
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:warning] = "You've signed out."
		redirect_to root_path
	end
end
