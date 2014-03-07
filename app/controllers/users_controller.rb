class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.create(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path

    else
      render :new
    end


  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
