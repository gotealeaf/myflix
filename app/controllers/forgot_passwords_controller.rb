class ForgotPasswordsController < ApplicationController
  
  def create
    user = User.where(email: params[:email]).first
    if user
      UserMailer.password_reset(user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:error] = "Invalid email address"
      redirect_to forgot_password_path
    end
  end
  
end