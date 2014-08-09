class InvitationsController < ApplicationController
  before_filter :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      AppMailer.delay.send_invitation_email(@invitation)
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}"
      redirect_to new_invitation_path
    else
      flash[:danger] = "There was an error."
      render :new
    end
  end

  def invitation_params
    params.require(:invitation).permit!.merge(inviter_id: current_user.id)
  end
end