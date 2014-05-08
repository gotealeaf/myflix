class InvitationsController < ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter: current_user))
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "#{@invitation.invitee_name} has been sent an invitation email."
      redirect_to home_path
    else
      flash[:warning] = "Please check the input below."
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_email, :invitee_name, :message)
  end
end