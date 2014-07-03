class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: @user.email, from: "welcome@myflix.com", subject: "Welcome to MyFliX!"
  end
end