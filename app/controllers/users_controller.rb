class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(category_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end