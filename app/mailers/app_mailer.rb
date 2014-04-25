class AppMailer < ActionMailer::Base
  def notify_on_registration(a_user_id)
    @a_user = User.find(a_user_id)
    #@a_user = a_user
    mail(from: 'info@myflix.com', to: @a_user.email, subject: "Thank you for Registering.")
  end

  def password_reset(a_user_id)
    @a_user = User.find(a_user_id)
    #@a_user = a_user
    mail(from: 'info@myflix.com', to: @a_user.email, subject: "Reset password")
  end

  def invite_a_user(invitation_id)
    @invitation = Invitation.find(invitation_id)
    #@invitation = invitation
    @a_user = @invitation.inviter.full_name
    mail(from: 'info@myflix.com', to: @invitation.guest_email, subject: "Join MyFLiX")
  end
end