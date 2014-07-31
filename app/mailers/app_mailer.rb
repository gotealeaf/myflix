class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email, subject: "Welcome to Myflix!"
  end

  def reset_password(user)
    @user = user
    mail from: "info@mylfix.com", to: user.email, subject: "Password Reset"
  end
end