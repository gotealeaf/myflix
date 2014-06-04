class UsersController < ApplicationController
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      flash[:info] = 'You have sucessfully login'
      redirect_to sign_in_path
    else
      render :new
    end 
  end

  def user_params
    params.require(:user).permit(:full_name, :password, :email)
  end
end