class FollowshipsController < ApplicationController
  before_action :require_user, :current_user
  def create
    follower = params[:follower_ids]
    follower.each do |follow_id|
      followee = User.find(follow_id[:id])
      if check_for_existing_followship?(followee)
        followship = setup_followship(followee)
        followship.save
        flash[:success] = "You are now successfully following #{followee.fullname}."
      else
        flash[:danger] = "You already are following #{followee.fullname}, you cannot follow them again."
      end
    end
    redirect_to followships_path
  end

  def index
    @users_followers = current_user.followers
    render
  end

  def destroy
    if Followship.exists?(params[:id])
      destroy_followship
      flash[:success] = "You are no longer following that user."
    else
      flash[:danger] = "There was an erorr when deleting the relationship."
    end
    redirect_to followships_path
  end

  private

  def check_for_existing_followship?(followee)
    number = Followship.where(user: current_user, follower_id: followee.id)
    if number == []
      true
    else
      false
    end
  end

  def setup_followship(followee)
    Followship.new(follower_id: followee.id, user_id: current_user.id)
  end

  def destroy_followship
    current_user.followships.find_by_id(params[:id]).destroy
  end
end
