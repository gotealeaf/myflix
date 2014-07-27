class MyflixMailer < ActionMailer::Base
  default from: 'admin@myflix.com'

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to MyFlix!'
  end

  def password_reset_email(password_reset)
    @user = password_reset.user
    @token = password_reset.token
    mail to: @user.email, subject: 'MyFlix password reset'
  end
end
