class InvitationsController < ApplicationController
  before_action :require_user

  def create
    redirect_to home_path
    Invitation.create(user: current_user, invitee_email: params[:email])
    flash[:success] = "An invitation email has been sent to your friend."
    
  end
end