class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email, subject: "Welcome to Myflix!"
  end

  def reset_password(user)
    @user = user
    mail from: "info@mylfix.com", to: user.email, subject: "Password Reset"
  end

  def invite_email(invite)
    @invite = invite
    mail from: "info@myflix.com", to: invite.friend_email, subject: "Invitation to join MyFlix!"
  end
end