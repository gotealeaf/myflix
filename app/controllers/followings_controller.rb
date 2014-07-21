class FollowingsController < ApplicationController
  before_action :require_user

  def index
    @followings = current_user.followings
  end

  def create
    @following = current_user.followings.find_by(followee_id: params[:user_id])
    unless current_user.id == params[:user_id].to_i || @following
      @following = Following.create(user: current_user, followee_id: params[:user_id] )
      flash[:success] = "You are now following #{ @following.full_name }"
    end
    redirect_to people_path
  end

  def destroy
    following = current_user.followings.find_by(followee_id: params[:id])
    if following
      following.delete
      flash[:success] = "You are no longer following #{ following.full_name }"
    end
    redirect_to people_path
  end
end
