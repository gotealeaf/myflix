class UsersController < ApplicationController
  def index
  end
  
  def new
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end