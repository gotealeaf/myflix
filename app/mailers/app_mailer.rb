class AppMailer < ActionMailer::Base

  def mail_to_leader_when_followed(leader, follower)
    @follower = follower
    mail from: 'info@myflix.com', to: leader.email, subject: "You have a new follower"
  end

  def welcome_email(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Welcome to MyFlix"

  end

  def send_forgot_password(user)
    @user = user
    mail from: 'info@myflix.com', to: user.email, subject: "Reset your password"

  end
end