class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
    render 'users/my_queue'
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = QueueItem.new(video: video, user: current_user)

    if queue_item.save  
      redirect_to my_queue_path
    else
      flash[:warning] = "This video has already been added to your queue."
      redirect_to video
    end
  end
end