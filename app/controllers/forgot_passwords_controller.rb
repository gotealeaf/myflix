class ForgotPasswordsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "Email cannot be blank!" : "There is no user with this email in the system!"
      redirect_to forgot_password_path
    end
  end
end
