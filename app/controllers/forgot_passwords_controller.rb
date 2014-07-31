class ForgotPasswordsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      user_token = UserToken.create(token: SecureRandom.urlsafe_base64, user: @user)
      MyflixMailer.password_reset_email(user_token).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:danger] = params[:email].blank? ? "Email can't be blank": "Email invalid"
      redirect_to forgot_password_path
    end
  end
end
