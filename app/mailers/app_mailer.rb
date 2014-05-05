class AppMailer < ActionMailer::Base
  def send_welcome_email user
    @user = user
    mail to: user.email, from: "unai.myflix@gmail.com", subject: "Welcome to Myflix #{user.full_name}!"
  end
end
