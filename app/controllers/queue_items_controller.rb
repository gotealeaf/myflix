class QueueItemsController < ApplicationController
 
   before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) unless already_queued?(video)
    redirect_to my_queue_path 
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy
    redirect_to my_queue_path
  end

  private  

  def already_queued?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def last_place
    current_user.queue_items.count + 1
  end

  def queue_video(video)
    QueueItem.create(position: last_place, video: video, user: current_user)  
   end 
  
end
  
