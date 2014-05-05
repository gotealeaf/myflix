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
      if Invitation.find_by_invitee_email(@user.email)
        UserRelationship.create(followee: Invitation.find_by_invitee_email(@user.email).user, follower: @user)
        UserRelationship.create(followee: @user, follower: Invitation.find_by_invitee_email(@user.email).user)
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
end