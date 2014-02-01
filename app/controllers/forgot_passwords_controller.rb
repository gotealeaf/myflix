class ForgotPasswordsController < ApplicationController
	def new
	end

	def create
		user = User.where(email: params[:email]).first
		if user
			AppMailer.delay.send_forgot_password(user.id)
			redirect_to forgot_password_confirmation_path
		else
		  flash[:error] = params[:email].blank? ? "Email cannot be blank" : "There is no registered user with that email"
		  redirect_to forgot_password_path
		end
	end

	def confirm
	end
end