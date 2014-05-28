class InvitationsController < ApplicationController
  def create
    # binding.pry
    if current_user
      if !params[:friend_email].blank? && !params[:friend_name].blank?
        AppMailer.send_invitation_email(current_user, params).deliver
        flash[:notice] = "Your invitation has been sent."
        redirect_to root_path
      else
        flash[:error] = "You have to fill Email and Friend's name fields."
        render :new
      end    
    else
      redirect_to sign_in_path
    end
  end
end