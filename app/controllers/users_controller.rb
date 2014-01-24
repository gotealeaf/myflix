class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Account created successfully, you have been logged in.'
      redirect_to home_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
