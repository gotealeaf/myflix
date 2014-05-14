class PasswordResetsController < ApplicationController
  def show
    @user = User.where(token: params[:id]).first
    if @user
      render :show
    else
      redirect_to expired_token_path
    end
  end

  def create
    user = User.where(token: params[:user_token]).first
    if user
      user.update_attributes(password: params[:password])
      user.change_token
      flash[:success] = "You reset your password. Please log in."
      redirect_to login_path
    else
      redirect_to expired_token_path
    end
  end
end