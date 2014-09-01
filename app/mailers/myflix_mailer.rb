class MyflixMailer < ActionMailer::Base
  default from: 'admin@myflix.com'

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Welcome to MyFlix!'
  end

  def password_reset_email(token_id)
    user_token = UserToken.find(token_id)
    @token = user_token.token
    @user = user_token.user
    mail to: @user.email, subject: 'MyFlix password reset'
  end

  def invite_friend(token_id, friend_name, friend_email, msg)
    user_token = UserToken.find(token_id)
    @inviter = user_token.user
    @friend_name = friend_name
    @friend_email = friend_email
    @token = user_token.token
    @message = msg
    mail to: @friend_email, from: @inviter.email, subject: "#{ @inviter.full_name } would like to see you on MyFlix!"
  end

  def account_suspension(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Account suspension'
  end
end
