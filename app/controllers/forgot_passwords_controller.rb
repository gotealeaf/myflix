class ForgotPasswordsController < ApplicationController
  def new
  end

  def create 
    user = User.where(email: params[:email]).first
    if user
      AppMail.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = "Email cannot be blank"
      redirect_to forgot_password_path 
    end
  end
end