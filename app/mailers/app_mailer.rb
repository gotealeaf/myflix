class AppMailer < ActionMailer::Base
  default from: ENV['SMTP_USER']

  def welcome_email(user)
    @user = user
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: 'Welcome to myflix')
  end
end
