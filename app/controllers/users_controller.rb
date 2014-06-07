class UsersController < ApplicationController
  before_action :can_register?, only: [:new]

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}!! You successfuly registered."
      redirect_to home_path
    else
      render :new
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def can_register?  
    if logged_in?
      flash[:danger] = "You have already registered for an account."
      redirect_to home_path
    end
  end

end