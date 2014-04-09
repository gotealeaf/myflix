class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    #binding.pry
    @user = User.new
  end
  def create
    @user = User.new(user_param)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "regisitered"
      redirect_to videos_path
    else
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @user.update(user_param)
      redirect_to root_path
    else
      flash[:error] = "invalid update"
      render :edit
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_param
    params.require(:user).permit(:name, :password, :email)
  end
end
