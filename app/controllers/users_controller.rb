class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
    @email = params[:email] if params[:email]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      AppMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered!"
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end