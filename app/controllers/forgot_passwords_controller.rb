class ForgotPasswordsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    @user = User.find_by_email(email)
    if @user.present?
      tok = SecureRandom::urlsafe_base64
      @user.update_attributes(token: tok)
      AppMailer.send_forgot_password(@user).deliver
    else
      flash[:errors] = 'Sorry. We cannot find that email address in our system.'
      redirect_to forgot_password_path
    end
  end

end
