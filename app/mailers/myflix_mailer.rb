class MyflixMailer < ActionMailer::Base
  default from: 'admin@myflix.com'

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to MyFlix!'
  end

  def password_reset_email(user_token)
    @user = user_token.user
    @token = user_token.token
    mail to: @user.email, subject: 'MyFlix password reset'
  end

  def invite_friend(inviter, invite_input)
    @inviter = inviter
    @friend_name = invite_input[:friend_name]
    @friend_email = invite_input[:friend_email]
    @message = invite_input[:message]
    mail to: @friend_email, from: inviter.email, subject: "#{ inviter.full_name } would like to see you on MyFlix!"
  end
end
