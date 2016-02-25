class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new

    @user = User.new
    
  end

  def create

    @user = User.create(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      AppMailer.welcome_email(@user).deliver
      redirect_to home_path

    else
      render :new
    end


  end

  def show
    @user = User.find_by slug: params[:id]

  end

  def follow

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
