class QueueItemsController < ApplicationController   
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) 
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if queue_item.user == current_user
    redirect_to my_queue_path
  end

  private 

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, order: new_queue_item_order) unless current_user_has_video?(video)   
  end

  def new_queue_item_order
    current_user.queue_items.count + 1
  end

  def current_user_has_video?(video)
    current_user.queue_items.map(&:video).include?(video)    
  end
end