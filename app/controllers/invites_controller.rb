class InvitesController < ApplicationController
  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.user = current_user
    
    if @invite.save
      AppMailer.delay.invite_email(@invite)
      flash[:notice] = "Success! Your invitation has been sent!"
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:friend_name, :friend_email)
  end
end