class FollowingsController < ApplicationController
  before_action :require_user
  before_action :set_followings, only: [:index, :create]

  def index;end

  def create
    followed = @followings.new(followed_user_id: params[:followed_user_id])

    if followed.save
      flash[:notice] = "Success! You are now following a new user."
      render :index
    else
      flash[:error] = "You are already following that user."
      redirect_to people_path
    end
  end

  def destroy
    followed = Following.find(params[:id])
    followed.destroy if current_user == followed.user
    flash[:notice] = "You have unfollowed that user."
    redirect_to people_path
  end

  private

  def set_followings
    @followings = current_user.followings
  end
end