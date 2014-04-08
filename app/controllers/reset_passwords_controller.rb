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
    binding.pry
    @user = User.where(token: params[:token]).first
    @user.password = password_reset_params
    @user.save
    redirect_to sign_in_path
  end
private

  def password_reset_params
    params.permit(:password)
  end
end