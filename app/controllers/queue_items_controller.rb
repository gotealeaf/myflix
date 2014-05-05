class QueueItemsController < ApplicationController
  before_action :require_user
  require 'pry'
  
  def index
    @queue_items = current_user.queue_items
  end
  
  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: current_user, list_order: new_queue_item_position) unless current_user_queued_items?(video)
    redirect_to my_queue_path  
  end
  
  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to my_queue_path
  end
  
  private
  
  def new_queue_item_position
    current_user.queue_items.count + 1
  end
  
  def current_user_queued_items?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
  
end