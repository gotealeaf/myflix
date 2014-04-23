class UserMailer < ActionMailer::Base
  default from: 'matthewbarram@gmail.com'

  def welcome_email(user)
    @user = user
    if Rails.env.production?
      mail(to: user.email, subject: "Thank you for signing up for MyFlix.")
    else
      mail(to: "matthewbarram@gmail.com", subject: "Thank you for signing up for MyFlix.")
    end
  end

  def password_reset_email(user)
    @user = user
    if Rails.env.production?
      mail(to: user.email, subject: "Password Reset for MyFlix.")
    else
      mail(to: "matthewbarram@gmail.com", subject: "Password Reset for MyFlix.")
    end
  end
end
