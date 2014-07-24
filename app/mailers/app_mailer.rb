require "haml/template/plugin"

class AppMailer < ActionMailer::Base
  def welcome_email(user)
    mail from: "info@myflix.com", to: user.email, subject: "Welcome to Myflix!"
  end
end