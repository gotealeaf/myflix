class AppMailer < ActionMailer::Base

  def send_welcome_email(user, friend_full_name)
    @user = user
    @friend_full_name = friend_full_name
    mail from: 'info@myflix.com', to: user.email, subject: "Welcome to MyFLix, #{@user.full_name}!"
  end

  def send_reset_password_email(email, user, reset_link)
    @email = email
    @user = user
    @reset_link = reset_link
    mail from: 'info@myflix.com', to: email, subject: "Reset Your Password"
  end

  def send_friend_email(email, friend, reset_link)
    @email = email
    @friend = friend
    @reset_link = reset_link
    mail from: 'info@myflix.com', to: friend.email, subject: "#{@friend.user.full_name} Has Invited You to Join MyFLix!"
  end
end