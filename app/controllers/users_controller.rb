class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user}!"
      redirect_to :root
    else
      render :new
    end
  end

  private

  def user_params
    require(:user).permit(:full_name, :email, :password, :slug)
  end
end
