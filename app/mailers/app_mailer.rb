class AppMailer < ActionMailer::Base
  def registration_email(user)
    @user = user
    mail from: 'info@myflixapp.com', to: user.email, subject: "Welcome to MyFlix, #{user.full_name}!"
  end

  def forgot_password_email(user)
    @user = user
    mail from: 'info@myflixapp.com', to: user.email, subject: "Password Reset"
  end

  def invite_email(invitation)
    @invitation = invitation
    mail from: 'info@myflixapp.com', to: invitation.recipient_email, subject: "#{invitation.inviter} has invited you to join MyFlix!"
  end
end