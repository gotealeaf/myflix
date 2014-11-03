class UserMailer < ActionMailer::Base
  default from: "mailbot@myflix.com"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to MyFlix!")
  end
end
