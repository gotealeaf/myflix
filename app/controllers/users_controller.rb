class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.full_name}!"
      session[:username] = @user.username
      MyflixMailer.welcome_email(current_user).deliver
      follow_inviter_if_invited
      redirect_to videos_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation)
  end

  def follow_inviter_if_invited
    unless params[:token].blank?
      inviter = UserToken.find_by(token: params[:token]).user
      Following.create(user: @user, followee: inviter)
      Following.create(user: inviter, followee: @user)
    end
  end
end
