class PasswordResetsController < ApplicationController

  def show
    @user = PasswordReset.find_by(token: params[:id]).user
    session[:id] = @user.id
    redirect_to reset_password_path
  end

  def new
  end

  def create
    @user = User.find(session[:id])
    if password_confirmation_match && @user.update_attributes(password: params[:password],
                            password_confirmation: params[:password_confirmation])
      session[:id] = nil
      @user.password_reset.delete
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
