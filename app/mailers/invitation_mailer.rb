class InvitationMailer < ActionMailer::Base
  default from: 'no-reply@myflix.com'

  def invitation_email(invitation)
    @invitation = invitation
    mail to: @invitation.recipient_email, subject: "Your friend invited you to join MyFlix!"
  end


end
