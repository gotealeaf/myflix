class AppMailer < ActionMailer::Base
  def notify_on_registration(a_user)
    @a_user = a_user
    mail(from: 'info@myflix.com', to: a_user.email, subject: "Thank you for Registering.")
  end

  def password_reset(a_user)
    @token = a_user.generate_token
    @a_user = a_user
    #@url = 'http://localhost:3000/submit_password'
    mail(from: 'info@myflix.com', to: a_user.email, subject: "Reset password")
  end
end