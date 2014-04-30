class UserMailer < ActionMailer::Base
  default from: 'charlesquirin@gmail.com'

  def registration_email(user)
    @user = user
    mail(to: @user.email, subject: 'MyFlix Registration')
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: 'MyFlix Password Reset')
  end
end