class AppMailer < ActionMailer::Base
  def registration_email(user)
    @user = user
    @url = 'http://tl-myflix.herokuapp.com/login'
    mail from: 'info@myflixapp.com', to: user.email, subject: "Welcome to MyFlix, #{user.full_name}!"
  end

  def forgot_password_email(user)
    @user = user
    @url = "reset_password/#{user.token}"
    mail from: 'info@myflixapp.com', to: user.email, subject: "Password Reset"
  end
end