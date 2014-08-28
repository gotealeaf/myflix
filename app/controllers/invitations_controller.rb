class InvitationsController < ApplicationController
  before_filter :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:error] = "Please fill out all the fields"
      render :new
    end
  end


  private

  def invitation_params
    params.
        require(:invitation).
        permit(:inviter_id, :recipient_name, :recipient_email, :message).
        merge!(inviter_id: current_user.id)
  end
end
