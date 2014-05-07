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

  def invite_email(invitation)
    @name = invitation.invitee_name
    @message = invitation.message
    mail(to: invitation.invitee_email, subject: 'MyFlix Invitation')
  end
end