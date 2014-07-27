class ForgotPasswordsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    password_reset = PasswordReset.create(token: SecureRandom.urlsafe_base64, user: @user)
    MyflixMailer.password_reset_email(password_reset).deliver
    redirect_to confirm_password_reset_path
  end
end
