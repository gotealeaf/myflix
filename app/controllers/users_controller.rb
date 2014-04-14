class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to sign_in_path
    else
      flash[:error] = "User couln't be created. #{@user.errors.full_messages.first}"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :password_confirmation)
  end
end