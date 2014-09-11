class AppMailer < ActionMailer::Base
  def welcome(user)
    @user = user
    mail from: 'loganrice72@gmail.com', to: user.email, subject: "Welcome to MyFlix"
  end
end

