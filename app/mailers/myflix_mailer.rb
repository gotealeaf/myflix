class MyflixMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, from: "info@myflix.com", subject: "Welcome to MyFLiX!")
  end

  def password_reset_email(user)
    @user = user
    mail(to: user.email,
         from: "info@myflix.com",
         subject: "Link To Reset Your MyFLiX Password")
  end
end
