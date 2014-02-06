class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
  end
end