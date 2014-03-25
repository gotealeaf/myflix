class FollowshipsController < ApplicationController
  before_action :require_user, :current_user

  def create
    follower_id = params[:follower_ids]
    followee = User.find(follower_id)
    if followee != current_user
      if check_for_existing_followship?(followee)
        finalise_followship(followee)
        flash[:success] = "You are now successfully following #{followee.fullname}."
      else
        flash[:danger] = "You already are following #{followee.fullname}, you cannot follow them again."
      end
    end
    redirect_to followships_path
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

  def followship_exist?
    followships = Followship.where(user: current_user, follower_id: params[:id].to_i)
    if followships == []
      false
    else
      true
    end
  end

  def finalise_followship(followee)
    followship = setup_followship(followee)
    followship.save
  end

  def setup_followship(followee)
    Followship.new(follower_id: followee.id, user_id: current_user.id)
  end

  def destroy_followship
    current_user.followships.where(follower_id: params[:id]).first.destroy
  end
end
