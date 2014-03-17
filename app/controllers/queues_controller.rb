class QueuesController < ApplicationController  
  before_action :require_user, only: [:index, :destroy]

  def index
    @user_videos = current_user.videos
    @user_reviews = current_user.reviews
  end

  def destroy
    current_user.user_videos.find_by(video_id: params[:id]).destroy
    redirect_to my_queue_path
  end
end