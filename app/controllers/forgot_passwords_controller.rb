class ForgotPasswordsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user 
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    elsif user != nil
      flash[:error] =       redirect_to forgot_password_path
    else
      flash[:error] = params[:email].blank? ? "Email can not be blank!" : "There is no user with that email in system."
      redirect_to forgot_password_path
    end
  end

  def confirm
  end
end
