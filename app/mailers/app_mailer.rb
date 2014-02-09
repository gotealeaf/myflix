class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
  end

  def send_reset_password_email(email, user, reset_link)
    @email = email
    @user = user
    @reset_link = reset_link
    mail from: 'info@myflix.com', to: email, subject: "Reset Your Password"
  end
end