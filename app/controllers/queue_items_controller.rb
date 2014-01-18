class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items
  end
  
  def create
    video = Video.find(params[:video_id])
    unless current_user.queue_items.map(&:video_id).include?(video.id)
      QueueItem.create(video: video, user: current_user, position: current_user.queue_items.count+1)
    end
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if current_user.queue_items.include?(queue_item)
      queue_item.delete
    end
    redirect_to my_queue_path
  end

end
