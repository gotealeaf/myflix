class InvitationsController < ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter: current_user))
    if @invitation.save
      AppMailer.invite_email(@invitation).deliver
      flash[:success] = "Your friend has been sent and invitation email."
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_email, :invitee_name, :message)
  end
end