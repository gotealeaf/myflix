class PasswordResetsController < ApplicationController
  def show
    redirect_to expired_token_path unless @user = User.find_by_token(params[:id])
  end

  def create
    if @user = User.find_by_token(params[:token])
      unless params[:password] == params[:password_confirmation]
        flash[:warning] = 'The passwords do not match.'
        redirect_to password_reset_path(@user.token)
      else
        update_password_and_regenerate_token(@user)
        flash[:success] = 'Your password has been reset. Please log in.'
        redirect_to sign_in_path
      end
    else
      redirect_to expired_token_path
    end
  end

  private

  def update_password_and_regenerate_token(user)
    user.update(password: params[:password], password_confirmation: params[:password_confirmation])
    user.generate_token
    user.save
  end
end