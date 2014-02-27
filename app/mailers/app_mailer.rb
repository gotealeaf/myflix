class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "mattflixinfo@gmail.com", subject: "Welcome to MattFlix!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "mattflixinfo@gmail.com", subject: "Please reset your password."
  end
end
