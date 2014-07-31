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

  def invite_friend(token, invite_input)
    @friend_name = invite_input[:friend_name]
    @friend_email = invite_input[:friend_email]
    @token = token
    @message = invite_input[:message]
    mail to: @friend_email, from: token.user.email, subject: "#{ token.user.full_name } would like to see you on MyFlix!"
  end
end
