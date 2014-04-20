class MyflixMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def welcome_email(user_id)
    @user = User.find(user_id)
    user_developer_email_if_in_staging
    mail(to: @user.email, from: "info@myflix.com", subject: "Welcome to MyFLiX!")
  end

  def password_reset_email(user)
    @user = user
    user_developer_email_if_in_staging
    mail(to: user.email,
         from: "info@myflix.com",
         subject: "Link To Reset Your MyFLiX Password")
  end

  def invitation_email(invitation, inviter)
    @invitation = invitation
    @user = inviter
    user_developer_email_if_in_staging
    mail(to: @invitation.friend_email,
         from: "info@myflix.com",
         subject: "#{@user.name} Has Envited You To MyFLiX")
  end

  # SET BUT DON"T SAVE THIS ONE
  def user_developer_email_if_in_staging
     @user.email = ENV['STAGING_EMAIL'] if ENV['RAILS_ENV'] == "staging"
  end
end
