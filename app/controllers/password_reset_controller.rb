class PasswordResetController < ApplicationController

  def show
    user = User.find_by_token(params[:id])
    if user
      @token = user.token
    else
      redirect_to invalid_token_path
    end
  end

  def create
    user = User.find_by_token(params[:token])
    if user
      user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      flash[:success] = "Password reset."
      redirect_to signin_path
    else
      redirect_to invalid_token_path
    end
  end

end
