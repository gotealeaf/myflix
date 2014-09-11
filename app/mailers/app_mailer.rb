class AppMailer < ActionMailer::Base
  def welcome(user)
    @user = user
    mail from: 'logan.rice@sigmagroup.solutions', to: user.email, subject: "Welcome to MyFlix"
  end
end

