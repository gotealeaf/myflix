class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix"
  end

  def send_password_reset_email(user)
    @user = user
    @user.generate_token
    mail to: user.email, from: "info@myflix.com", subject: "Reset your password"
  end
end