class ForgotPasswordsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user
      AppMailer.forgot_password_email(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "Email cannot be blank." : "Sorry, that email does not exist in our records."
      redirect_to forgot_password_path
    end
  end
end