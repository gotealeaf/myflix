class RelationshipsController < ApplicationController
  def create
    binding.pry
    @user = User.find_by_id(params[:user_id])
    if current_user.following?(@user)
      flash[:notice] = "You are already following this user"
    else
      current_user.follow!(@user)
    end
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    redirect_to users_path
  end
end