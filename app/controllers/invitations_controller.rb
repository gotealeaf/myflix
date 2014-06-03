class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:notice] = "Your invitation has been sent."
      redirect_to new_invitation_path
    else
      flash[:error] = "You have to fill Email and Friend's name fields."
      render :new
    end
  end

  private
    def invitation_params
      params.require(:invitation).permit(:recipient_name, :recipient_email, :invitation_message).merge!(inviter_id: current_user.id)
    end  
end