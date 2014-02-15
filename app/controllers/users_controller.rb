class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_token
    @user = User.new
    friend = Friend.where(token: params[:token]).first
    if friend
      @user.full_name = friend.full_name
      @user.email = friend.email
      @token = friend.token
      render :new
    else
      redirect_to password_followup_expired_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      handle_friendship
      @friend_full_name = @friend.user.full_name if @friend
      AppMailer.send_welcome_email(@user, @friend_full_name).deliver
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by_token(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def handle_friendship
    @friend = Friend.where(token: params[:token]).first if params[:token]
    if @friend
      Relationship.create(follower_id: @user.id, leader_id: @friend.user_id) if @user.allow_to_follow?(@friend.user)
      Relationship.create(follower_id: @friend.user_id, leader_id: @user.id) if @friend.user.allow_to_follow?(@user)
    end
  end
end