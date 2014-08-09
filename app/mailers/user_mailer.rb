class UserMailer < ActionMailer::Base
  default from: 'no-reply@myflix.com'

  def welcome_email(user)
    @user = user

    mail to: @user.email, subject: "Welcome to MyFlix"
  end

  def send_password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password Reset"
  end

  def invitation_email(invitation)
    @invitation = invitation
    mail to: @invitation.recipient_email, subject: "Your friend invited you to join MyFlix!"
  end


end
