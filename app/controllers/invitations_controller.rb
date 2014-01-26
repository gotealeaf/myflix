class InvitationsController < ApplicationController
	before_action :require_user

	def new
		@invitation = Invitation.new
	end

	def create
		Invitation.create(invitation_params.merge!(inviter_id: current_user.id))
		redirect_to new_invitation_path
	end

	private

	def invitation_params
		params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
	end
end