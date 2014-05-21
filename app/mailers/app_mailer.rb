class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
  end
  
  def send_forgot_password_email(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Password Reset Link"
  end
  
  def send_invitation_email(invitation)
    @invitation = invitation
    mail from: 'info@myflix.com', to: invitation.recipient_email, subject: "Invitation to join MyFlix!"
  end
end