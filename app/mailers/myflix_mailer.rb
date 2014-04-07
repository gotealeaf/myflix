class MyflixMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to MyFLiX!")
  end

  def password_reset_email(user)
    @user = user
    @url  = ""#reset_password_url(@user.password_reset_token)
    mail(to: user.email,
         host: "http://arcane-stream-2628.herokuapp.com/",
         subject: "Link To Reset Your MyFlix Password")
  end
end
