class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: @user.email, from: "info@myflix.com", subject: "Welcome to MyFliX!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: @user.email, from: "info@myflix.com", subject: "Password reset link"
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: "info@myflix.com", subject: "You've been invited to join MyFliX!"
  end
end