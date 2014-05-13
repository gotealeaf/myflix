class ResetPasswordsController < ApplicationController
  def show
    @user = User.where(token: params[:id]).first
    if @user
      @token = @user.token
    else
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.where(token: params[:token]).first
    if @user
      @user.password = password_reset_params[:password]
      @user.update_columns(token: SecureRandom.urlsafe_base64)
      @user.save
      flash[:notice] = "Please go to the log in page and sign in with your new password."
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end
  end

  def expired_token
  end

private

  def password_reset_params
    params.permit(:password)
  end
end