class AppMailer < ActionMailer::Base


  def send_password_reset(email)
    @email = email
    mail from: 'info@myflix.com', to: 'rick.heller@yahoo.com', subject: "Password Reset" 
  end

  def notify_on_new(user)
    @user = user
#dont sent emails to random users, send to my yahoo account.
    #mail from: 'info@myflix.com', to: user.email, subject: "Welcome to RickMyflix" 
    mail from: 'info@myflix.com', to: 'rick.heller@yahoo.com', subject: "Welcome to RickMyflix" 
  end
end
