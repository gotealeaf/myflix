class MyflixMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, from: "info@myflix.com", subject: "Welcome to MyFLiX!")
  end

  def password_reset_email(user)
    @user = user
    mail(to: user.email,
         from: "info@myflix.com",
         subject: "Link To Reset Your MyFLiX Password")
  end

  def invitation_email(invitation, inviter)
    @invitation = invitation
    @user = inviter
    mail(to: @invitation.friend_email,
         from: "info@myflix.com",
         subject: "#{@user.name} Has Envited You To MyFLiX")
  end
end
