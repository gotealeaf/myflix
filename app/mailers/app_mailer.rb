class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: @user.email, from: "info@myflix.com", subject: "Welcome to MyFliX!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: @user.email, from: "info@myflix.com", subject: "Password reset link"
  end
end