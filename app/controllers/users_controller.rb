class UsersController < ApplicationController
  def new
    flash[:warning] = "You are already logged in."
    redirect_to home_path and return if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end