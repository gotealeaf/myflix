class MyflixMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def welcome_email(user)
    @user = user
    @url = 'http://'#add heroku app address to login here
    mail(to: @user.email, subject: "Welcome to MyFLiX!")
  end
end
