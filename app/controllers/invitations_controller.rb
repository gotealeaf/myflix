class InvitationsController < ApplicationController

  before_action :require_user, :current_user

  def create
    if search_for_user_email
      invite = create_invitation
      if invite.save
        send_invitation
        flash[:success] = "Your invitation has been successfully sent."
      else
        flash[:danger] = "The details you entered were invalid, please correct and resubmit them."
      end
    else
      flash[:danger] = "The person you are trying to invite either has an existing invitation OR they are already a user of myflix."
    end
    redirect_to new_invitation_path
  end

  def new
    @invitee_details = Invitation.new
  end

  private

  def create_invitation
    Invitation.new(email: params[:invitation][:email], fullname: params[:invitation][:fullname], user_id: session[:user_id], status: "pending", message: "this is a message to the user", invite_token: SecureRandom.urlsafe_base64)
  end

  def send_invitation
    InvitationMailer.invite_user_email(invite).deliver
  end

  def search_for_user_email
    invite_search = Invitation.find_by email: params[:invitation][:email]
    user_search = User.find_by email: params[:invitation][:email]
    if invite_search == nil && user_search == nil
      true
    else
      false
    end
  end

end
