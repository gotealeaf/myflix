class InvitationMailer
  include Sidekiq::Worker

  # with delay syntax
  def self.email_invitation(invitation_id)
    invitation = Invitation.find(invitation_id)
    AppMailer.invite_email(invitation).deliver
  end

  # with perform_async syntax
  # def perform(invitation_id)
  #   invitation = Invitation.find(invitation_id)
  #   AppMailer.invite_email(invitation).deliver
  # end
end