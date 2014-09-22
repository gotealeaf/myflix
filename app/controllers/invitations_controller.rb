class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    # binding.pry
    @invitation = current_user.invitations.new(invitation_params)
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}"
      redirect_to new_invitation_path
    else
      flash[:error] = "Sorry, there was an error. Please check your input"
      render :new
    end

  end

  private 

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :recipient_name, :message)
  end
end