class AppMailer < ActionMailer::Base

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail from: 'info@myflix.com', to: @user.email, subject: "Welcome to Myflix"
  end

  def send_forgot_password(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Password Reset Request"
  end

  def send_invitation(invitation)
    @invitation = invitation
    mail from: 'info@myflix.com', to: invitation.recipient_email, subject: "Join this great cool site!"
    
  end

end
