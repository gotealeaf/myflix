class AppMailer < ActionMailer::Base
  
  def send_welcome_email(user)
    @user = user
    mail(from: "info@myflix.com", to: user.email, subject: "Welcome to Myflix!")
  end

  def send_forgot_password(user)
    @user = user
    mail(from: "info@myflix.com", to: user.email, subjec: "Please reset your password")
  end
end