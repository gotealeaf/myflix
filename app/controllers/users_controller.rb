class UsersController < ApplicationController

  def new  
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sign_in_path, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :salt, :encrypted_password)
  end
end