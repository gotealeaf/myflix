class FollowshipsController < ApplicationController

  include FollowshipHelper

  before_action :require_user, :current_user

  def create
    follower_id = params[:follower_ids]
    create_followship(follower_id, current_user.id)
    redirect_to people_path
  end

  def index
    @users_followers = current_user.followers
  end

  def destroy
    if followship_exist?
      destroy_followship
      flash[:success] = "You are no longer following that user."
    else
      flash[:danger] = "There was an erorr when deleting the relationship."
    end
    redirect_to people_path
  end

  private

  def followship_exist?
    followships = Followship.where(user: current_user, follower_id: params[:id].to_i)
    if followships == []
      false
    else
      true
    end
  end

  def destroy_followship
    current_user.followships.where(follower_id: params[:id]).first.destroy
  end
end
