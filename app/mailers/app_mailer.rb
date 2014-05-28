class AppMailer < ActionMailer::Base
  def send_welcome_email user
    @user = user
    mail to: user.email, from: "unai.myflix@gmail.com", subject: "Welcome to Myflix #{user.full_name}!"
  end

  def send_forgot_password_email user
    @user = user
    mail to: user.email, from: "unai.myflix@gmail.com", subject: "Forgot password."
  end

  def send_invitation_email user, input
    @user = user
    @input = input
    mail to: input[:friend_email], from: "unai.myflix@gmail.com", subject: "MyFlix Inviotation"
  end
end
