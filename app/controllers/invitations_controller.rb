class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.delay.invite_a_user(@invitation.id)
      flash[:notice] = "Your invitation has been sent."
      redirect_to new_invitation_path
    else
      flash[:notice] = "Please fill out the form entirely."
      render "new"
    end
  end

private

  def invitation_params
    params.require(:invitation).permit(:guest_email, :guest_name, :message, :inviter_id)
    
  end
end