class UserMailer < ActionMailer::Base
  default from: 'matthewbarram@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Thank you for signing up for MyFlix.")
  end

  def password_reset_email(user)
    @user = user
    mail(to: user.email, subject: "Password Reset for MyFlix.")
  end
end
