class QueueItemsController < ApplicationController
  before_action :require_user
  
  def index
    @queue_items = current_user.queue_items
  end
  
  def create
    queue_video(Video.find(params[:video_id]))
    redirect_to my_queue_path
  end
  
  def destroy
    item = current_user.queue_items.where(id: params[:id]).first
    item.destroy if item
    redirect_to my_queue_path
  end
  
  private
  
  def queue_video(video)
    QueueItem.create(user: current_user, video: video, position: new_queue_item_position) unless video_exists_in_users_queue?(video)
  end

  def new_queue_item_position
    current_user.queue_items.count+1
  end
  
  def video_exists_in_users_queue?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
  
  
end