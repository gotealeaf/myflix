class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "You must enter your email address.": "The email address is not in the system."
      redirect_to forgot_password_path
    end
  end
end