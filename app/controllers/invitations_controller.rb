class InvitationsController < ApplicationController
  before_action :signed_in_user

  def new
    @invitation = Invitation.new
  end


  def create
    unless User.find_by_email(params[:recipient_name])

      @invitation = Invitation.new(invitation_params)
      @invitation.inviter_id = current_user.id

      if @invitation.save
        InvitationMailer.invitation_email(@invitation).deliver
        flash[:success] = "Invition has been send out."
        redirect_to new_invitation_path
      else
        render :new
      end
    else
      flash[:info] = "Your friend has joined Myflix."
    end
  end


  private

    def invitation_params
      params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
    end
end
