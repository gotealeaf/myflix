class AppMailer < ActionMailer::Base
  def welcome(user)
    @user = user
    mail from: 'logan.rice@sigmagroup.solutions', to: user.email, subject: "Welcome to MyFlix"
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Please reset your password"
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: "info@myflix.com", subject: "Check out this cool site"
  end
end

