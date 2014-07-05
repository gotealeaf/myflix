class ForgotPasswordsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "Email can't be blank." : "There is no user registered with that email address."
      redirect_to forgot_password_path
    end
  end

  def confirm
    
  end
end
