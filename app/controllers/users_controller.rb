class UsersController < ApplicationController
  
  before_action :require_user, only: [:show, :following, :follow, :unfollow]
  
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
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
  
  def following
  end
  
  def follow
    relationship = Relationship.new(follower_id: current_user.id, following_id: params[:id])
    if relationship.valid?
      relationship.save
      redirect_to following_path
    else
      @user = User.find(params[:id])
      render :show
    end
  end
  
  def unfollow
    user = User.find(params[:id])
    rel = Relationship.where(follower: current_user, following: user).first
    if user && rel
      rel.destroy
      redirect_to following_path
    else
      render :following
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
  
end