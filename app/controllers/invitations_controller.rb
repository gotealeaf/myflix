class InvitationsController < ApplicationController
  before_action :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter: current_user))
    if @invitation.save
      AppMailer.delay.send_invitation(@invitation)
      flash[:info] = "You have successfully invite #{@invitation.recipient_name}!"
      redirect_to new_invitation_path
    else
      flash[:danger] = "Please check your input!"
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :recipient_name, :message)
  end
end
