class AppMailer < ActionMailer::Base
  def registration_email(user)
    @user = user
    @url = 'http://tl-myflix.herokuapp.com/login'
    mail from: 'info@myflixapp.com', to: user.email, subject: "Welcome to MyFlix, #{user.full_name}!"
  end
end