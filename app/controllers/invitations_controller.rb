class InvitationsController < ApplicationController
  before_action :require_signed_in

  def new
    @invitation = Invitation.new
  end

  def create
    @user = current_user
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: @user.id, token: nil))
    if @invitation.save
      MyflixMailer::invitation_email(@invitation, @user).deliver
      flash[:notice] = "Invitation sent successfully!"
      redirect_to invite_path
    else
      flash.now[:error] = "Sorry, looks like something is off..."
      render 'new'
    end
  end


  private

    def invitation_params
      params.require(:invitation).permit(:friend_name, :friend_email, :message)
    end
end
