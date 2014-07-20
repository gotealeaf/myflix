class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def edit
    
  end

  def update

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end
