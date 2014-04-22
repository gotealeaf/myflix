class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to sign_in_path
    else
      flash[:error] = "User couldn't be created. #{@user.errors.full_messages.first}"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :password_confirmation)
  end
end