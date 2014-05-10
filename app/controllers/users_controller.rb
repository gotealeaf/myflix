class UsersController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    end
    
    @user = User.new
  end

  def new_from_invitation
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    elsif invitation = Invitation.find_by_token(params[:token])
      @user = User.new(email: invitation.invitee_email, full_name: invitation.invitee_name )
      render :new
    else
      flash[:warning] = "The token is expired but you can still register."
      redirect_to register_path
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      AppMailer.registration_email(@user).deliver

      if invitation = Invitation.find_by_invitee_email(@user.email)
        create_relationships_from_invitation(invitation)
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

  def create_relationships_from_invitation(invitation)
    UserRelationship.create(followee: invitation.inviter, follower: User.find_by_email(invitation.invitee_email))
    UserRelationship.create(followee: User.find_by_email(invitation.invitee_email), follower: invitation.inviter)
  end
end