class InvitationsController < ApplicationController
  before_action :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.create(invitation_params)
    AppMailer.send_invitation_email(invitation).deliver 
    redirect_to new_invitation_path
  end

  private
    def invitation_params
      params.require(:invitation).permit(:inviter_id, :recipient_name, :recipient_email, :message)
    end
end