class AppMailer < ActionMailer::Base
  default from: 'charlesquirin@gmail.com'

  def registration_email(user)
    @user = user
    mail(to: @user.email, subject: 'MyFlix Registration')
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: 'MyFlix Password Reset')
  end

  def invite_email(email, full_name)
    @name = full_name
    mail(to: email, subject: 'MyFlix Invitation')
  end
end