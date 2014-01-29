class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id]) if params[:video_id]

    if video
      QueueItem.create(user: current_user, video: video, position: QueueItem.next_available_position(current_user))
      flash[:success] = "#{video.title} was successfully added to your queue."
    else
      flash[:danger] = 'There was a problem adding the video to your queue. Please try again.'
    end

    redirect_to :back
  end

  def destroy
    if current_user == QueueItem.find(params[:id]).user
      QueueItem.destroy(params[:id])
      flash[:success] = 'The video was successfully removed from your queue.'
    else
      flash[:danger] = 'There was a problem removing the video from your queue.'
    end
    redirect_to :back
  end
end
