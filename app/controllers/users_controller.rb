class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    invite = Invite.find_by(token: params[:invite_token])
    
    if @user.save
      if invite
        @user.follow_and_be_followed_by(invite.user)
        invite.generate_token
      end
      AppMailer.delay.welcome_email(@user)
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered!"
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invite_token
    invite = Invite.find_by(token: params[:token])

    if invite
      @user = User.new(email: invite.friend_email)
      @invite_token = invite.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end