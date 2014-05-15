class ForgotPasswordsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
      AppMailer.send_forgot_password_email(user).deliver
      user.update_column(:reset_password_email_sent_at, ActionMailer::Base.deliveries.last.date) if ActionMailer::Base.deliveries.last
      binding.pry
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email field cannot be blank." : "There is no user with that email in the system"
      redirect_to forgot_password_path
    end
  end
end