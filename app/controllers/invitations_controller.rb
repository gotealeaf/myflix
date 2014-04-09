class InvitationsController < ApplicationController
  def new
  end

  def create
    @mail_content = {}
    @mail_content = {"email" => params[:email], "full_name" => params[:full_name], "description" => params[:description]}
    #binding.pry
    if @mail_content.has_value?(nil)
      flash[:notice] = "Please fill out the form entirely."
      render "new"
    else
      AppMailer.invite_a_user(@mail_content, current_user).deliver
      invite = Invitation.create(guest_email: @mail_content["email"], inviter_email: current_user.email)
      flash[:notice] = "Your invitation has been sent."
      redirect_to videos_path
    end
  end
end