class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(person_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
  def person_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
