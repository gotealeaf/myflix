class PasswordResetController < ApplicationController

  def show
    user = User.find_by_token(params[:id])
    if user
      @token = user.token
    else
      render :invalid_token
    end
  end

  def create
    user = User.find_by_token(params[:token])
    if user
      user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      flash[:success] = "Password reset."
      redirect_to signin_path
    else
      render :invalid_token
    end
  end

end
