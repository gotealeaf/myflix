class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have been registered"
      redirect_to sign_in_path
    else
      render :new
    end
  end
  
  def show
    @user = current_user
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
  
end