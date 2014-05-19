class ForgotPasswordsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.where(email: params[:email]).first
    if @user
      AppMailer.send_forgot_password_email(@user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "You did not enter an email address." : "There is no user associated with that email address."
      redirect_to forgot_password_path
    end
  end
  
  def confirm
  end
  
end