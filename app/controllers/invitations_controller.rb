class InvitationsController < ApplicationController
  before_filter :require_user

  
  def new
    @invitation = Invitation.new
  end
  
  def create
    @user = current_user
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: current_user.id)) #unless new_invite?(@recipient)
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "Your invitation to #{@invitation.recipient_name} has been delivered."
      redirect_to new_invitation_path
    else
      flash[:danger] = "Please check your input. All fields must be filled in."
      render :new
    end
  end
  
  private
  
  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end
  
end