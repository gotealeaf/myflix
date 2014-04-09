class InvitationsController < ApplicationController
  def new
  end

  def create
    @mail_content = {}
    @mail_content = {"email" => params[:email], "full_name" => params[:full_name], "description" => params[:description]}
    AppMailer.invite_a_user(@mail_content, current_user).deliver
    flash[:notice] = "Your invitation has been sent."
    redirect_to videos_path
  end
end