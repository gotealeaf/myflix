require "pry"
class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    AppMailer.reset_password(user).deliver if user

    if params[:email].blank?
      flash[:error] = "Email cannot be blank."
      render :new
    else
      redirect_to confirm_password_reset_path
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    redirect_to expired_token_path unless @user
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    @user.update_attributes(params.permit![:user])

    if @user.save
      flash[:notice] = "Success! New password saved."
      @user.generate_password_reset_token
      redirect_to login_path
    else
      render :edit
    end
  end
end