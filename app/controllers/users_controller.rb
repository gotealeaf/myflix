class UsersController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    end
    
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      AppMailer.registration_email(@user).deliver

      if invite = Invitation.find_by_invitee_email(@user.email)
        create_relationships_from_invite(invite)
      end

      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    require_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end

  def create_relationships_from_invite(invite)
    UserRelationship.create(followee: invite.inviter, follower: User.find_by_email(invite.invitee_email))
    UserRelationship.create(followee: User.find_by_email(invite.invitee_email), follower: invite.inviter)
  end
end