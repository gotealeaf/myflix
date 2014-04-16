class InvitationsController < ApplicationController

  before_action :require_user, :current_user

  def create
    invite = Invitation.new(email: params[:invitee_details][:email], fullname: params[:invitee_details][:fullname], user_id: session[:user_id], status: "pending", message: "this is a message to the user")
    invite.save
    redirect_to new_invitation_path
  end

end
