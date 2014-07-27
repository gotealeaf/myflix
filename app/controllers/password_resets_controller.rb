class PasswordResetsController < ApplicationController

  def show
    @user = PasswordReset.find_by(token: params[:id]).user
    session[:id] = @user.id
    redirect_to reset_password_path
  end

  def new
    @user = User.find(session[:id])
  end

  def create
    @user = User.find(session[:id])
    binding.pry
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      session[:id] = nil
      @user.password_reset.delete
      flash[:success] = "You password has been reset!"
      redirect_to sign_in_path
    else
      flash[:danger] = @user.errors.full_messages.first
      redirect_to reset_password_path
    end
  end
end
