class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :signed_in_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome!"
      redirect_to root_path
    else
      render :new
    end
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
