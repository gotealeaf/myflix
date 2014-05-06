class InvitationsController < ApplicationController
  before_action :require_user

  def create
    invitee_email = params[:email]
    if invitee = User.find_by_email(invitee_email)
      flash[:warning] = "#{invitee.full_name} is already registered."
      redirect_to user_path(invitee)
    else
      invitation = Invitation.create(inviter: current_user, invitee_email: invitee_email)
      flash[:success] = "An invitation email has been sent to your friend."
      AppMailer.invite_email(invitation.invitee_email, params[:full_name]).deliver
      redirect_to home_path
    end
  end
end