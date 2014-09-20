class ForgotPasswordsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    user = User.find_by_email(email)
    @found_email = user.present?
    if @found_email
      @tok = SecureRandom::urlsafe_base64
logger.info "***rick token is " + @tok.inspect
      user.update_attributes(token: @tok)
      AppMailer.send_password_reset(email).deliver
    end
  end

end
