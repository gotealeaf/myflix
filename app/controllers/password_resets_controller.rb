class PasswordResetsController < ApplicationController

  def show
    @user_token = UserToken.find_by(token: params[:id])
    if @user_token
      @user = @user_token.user
      @token = params[:id]
    else
      redirect_to invalid_token_path
    end
  end

  def create
    @user_token = UserToken.find_by(token: params[:token])
    @user = @user_token.user
    if password_confirmation_match && @user.update_attributes(password: params[:password],
                            password_confirmation: params[:password_confirmation])
      @user_token.delete
      flash[:success] = "Your password has been reset!"
      redirect_to sign_in_path
    else
      flash[:danger] = "Password or confirmation is not valid please try again."
      redirect_to reset_password_path
    end
  end

  private

  def password_confirmation_match
    params[:password] == params[:password_confirmation]
  end

end
