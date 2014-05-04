class QueueItemsController < ApplicationController
  before_action :require_user
  
  def index
    @queue_items = current_user.queue_items
  end
  
  def create
    video = Video.find(params[:video_id])
    new_item = QueueItem.create(video: video, user: current_user)
    if new_item.save
      flash[:success] = "Your video was successfully added to the queue"
      redirect_to my_queue_path
    else
      flash[:danger] = "Your video could not be added to the queue"
      redirect_to video_path(video)
    end
  end
  
end