class PasswordResetsController < ApplicationController

  def expired_token
    # Static page
  end

  def show
    @user  = User.where(token: params[:id]).first
    if user_valid_but_token_invalid?
      @user.set_token_data_invalid
      redirect_to expired_token_path
    elsif user_and_token_valid?
      @token = params[:id]
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.where(token: params[:token]).first
    if user_valid_but_token_invalid?(3)
      @user.set_token_data_invalid
      redirect_to expired_token_path
    elsif user_and_token_valid?(3)
      update_valid_password_or_retry
    else
      redirect_to root_path
    end
  end

  ############################## PRIVATE METHODS ###############################
  private

  def user_valid_but_token_invalid?(timeframe=2)
    @user && @user.token_expired?(timeframe)
  end

  def user_and_token_valid?(timeframe=2)
    @user && !@user.token_expired?(timeframe)
  end

  def update_valid_password_or_retry
    if @user.update(password: params[:password])
      flash[:notice] = "Password successfully changed. Please login with new password."
      @user.set_token_data_invalid
      redirect_to signin_path
    else
      flash[:notice] = "Password invalid. Please must be a minimum of 6 characters."
      redirect_to password_reset_path(params[:token])
    end
  end
end
