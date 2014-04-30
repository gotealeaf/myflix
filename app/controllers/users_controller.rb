class UsersController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    require_user
    @user = User.find(params[:id])
  end

  def reset_email
    if user = User.find_by_email(params[:email])
      user.generate_password_token
      render :confirm_password_reset
    else
      flash[:warning] = 'Your email address is not recognized.'
      redirect_to forgot_password_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end