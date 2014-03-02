class UsersController < ApplicationController
  before_action 

  def new
    if current_user
      redirect_to videos_path 
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to videos_path, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end