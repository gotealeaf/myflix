class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.full_name}!"
      session[:username] = @user.username
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
end
