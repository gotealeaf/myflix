class InvitationsController < ApplicationController
  
  before_action :require_user, except: :show
  
  def create
    invitation = Invitation.create(friend_email: params[:friend_email], user_id: current_user.id) unless already_invited?(params[:friend_email])
    if invitation
      invite_id = Invitation.find_by(friend_email: params[:friend_email]).id
      UserMailer.delay.invite_email(current_user.id, invite_id, params[:friend_name], params[:invitation_message])
      flash[:success] = "Your invitation has been sent"
    else
      flash[:error] = "That user has already been invited"
    end
    redirect_to invite_path
  end
  
  def show
    @user = User.new
    invitation = Invitation.find_by(token: params[:id])
    if invitation
      @friend_email = invitation.friend_email
      render 'users/new'
    else
      redirect_to invalid_token_path
    end
  end
  
  private
  
  def already_invited?(friend_email)
    Invitation.all.map(&:friend_email).include?(friend_email)
  end
  
end