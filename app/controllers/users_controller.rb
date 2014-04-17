class UsersController < ApplicationController
  before_action :require_user, :current_user, only: [:show]
  def new
    if session[:user_id]
      redirect_to home_path
    else
      @user = User.new
      if params[:invite_token] != nil
        invitation = find_invitation
        if invitation == nil
          flash[:danger] = "That is not a valid invite token. Please contact the person who invited you for a valid one."
          redirect_to register_path
        else
          @user.fullname = invitation.fullname
          @user.email = invitation.email
        end
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created!"
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def find_invitation
    Invitation.find_by invite_token: params[:invite_token]
  end

  def user_params
    params.require(:user).permit(:password, :email, :fullname)
  end
end
