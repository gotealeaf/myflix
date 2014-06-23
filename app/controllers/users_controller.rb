class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.full_name}!"
      session[:user] = @user.username
      redirect_to videos_path
    else
      flash.now[:danger] = @user.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation)
  end
end
