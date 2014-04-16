class InvitationMailer < ActionMailer::Base
  default from: 'matthewbarram@gmail.com'

  def invite_user_email(invitee_details)
    @invitee_details = invitee_details
    mail(to: invitee_details.email, subject: "You have been invited to sign up for Myflix.")
  end
end
