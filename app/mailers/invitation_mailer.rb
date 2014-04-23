class InvitationMailer < ActionMailer::Base
  default from: 'matthewbarram@gmail.com'

  def invite_user_email(invitee_details)
    @invitee_details = invitee_details
    if Rails.env.production?
      mail(to: "invitee_details.email", subject: "You have been invited to sign up for Myflix.")
    else
      mail(to: "matthewbarram@gmail.com", subject: "You have been invited to sign up for Myflix.")
    end
  end
end
