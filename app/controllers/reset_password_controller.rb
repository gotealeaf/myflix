class ResetPasswordController < ApplicationController

  def create
    email = params[:email]
    user = User.where(email: email).first
    if user
      AppMailer.delay.send_reset_password_email(email, user, link_for_reset(user.token))
    else 
      flash[:error] = email.empty? ? "Please enter an email address." : "There is no user with that email address."
      redirect_to forgot_password_path
      return
    end
    redirect_to confirm_password_path
  end

  private

  def link_for_reset(token)
    if request.host == 'localhost'
      request.protocol + request.host_with_port + '/reset_password_followup/' + token
    else
      request.protocol + request.host + '/reset_password_followup/' + token
    end
  end
end