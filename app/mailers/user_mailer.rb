class UserMailer < ActionMailer::Base
  default from: "mailbot@myflix.com"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to MyFlix!")
  end
  
  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "MyFlix password reset")
  end
  
  def invite_email(sender, invite, friend_name, message)
    @sender = sender
    @invite = invite
    @friend_name = friend_name
    @message = message
    mail(to: @invite.friend_email, subject: "Come join MyFlix!")
  end
  
end