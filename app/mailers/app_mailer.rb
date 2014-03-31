class AppMailer < ActionMailer::Base
  default from: "desmonddai583@gmail.com"

  def send_welcome_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Myflix"
  end

  def send_forgot_password(user)
    @user = user
    mail to: @user.email, subject: "Please reset your password"
  end

  def send_invitation(invitation)
    @invitation = invitation
    mail to: @invitation.recipient_email, subject: "Join MyFlix"
  end
end
