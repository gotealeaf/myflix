class MyflixMailer < ActionMailer::Base
  default from: 'admin@myflix.com'
  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to MyFlix!'
  end
end
