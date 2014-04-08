class PasswordResetsController < ApplicationController

  def expired_token
    # Static page
  end

  def show
    @user  = User.where(password_reset_token: params[:id]).first
    if user_valid_but_token_invalid?(2)
      clear_reset_token_and_redirect
    elsif user_and_token_valid?(2)
      @token = params[:id]
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.where(password_reset_token: params[:token]).first
    if user_valid_but_token_invalid?(3)
      clear_reset_token_and_redirect
    elsif user_and_token_valid?(3)
      update_valid_password_or_retry
    else
      redirect_to root_path
    end
  end

  ############################## PRIVATE METHODS ###############################
  private

  def user_valid_but_token_invalid?(timeframe)
    @user && @user.token_expired?(timeframe)
  end

  def user_and_token_valid?(timeframe)
    @user && !@user.token_expired?(timeframe)
  end

  def clear_reset_token_and_redirect
    @user.update_columns(password_reset_token: nil)
    redirect_to expired_token_path
  end

  def update_valid_password_or_retry
    if @user.update(password: params[:password])
      flash[:notice] = "Password successfully changed. Please login with new password."
      redirect_to signin_path
    else
      flash[:notice] = "Password invalid. Please must be a minimum of 6 characters."
      redirect_to password_reset_path(params[:token])
    end
  end
end
