class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user_signup = UserSignup.new(@user).sign_up(params[:stripeToken], params[:token])
    if user_signup.successful?
      flash[:success] = "Welcome #{@user.full_name}!"
      session[:username] = @user.username
      redirect_to videos_path
    else
      flash[:danger] = user_signup.error_message
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :full_name, :email, :password, :password_confirmation)
  end
end
