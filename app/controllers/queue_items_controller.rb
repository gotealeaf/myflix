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

  def update_queue
    # unless current_user.queue_items.empty?
    unless params[:queue_items].nil?
      params[:queue_items].each  do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes(position: queue_item_data["position"]) if queue_item.user == current_user
      end
      current_user.queue_items.each_with_index  do |queue_item, index|
        queue_item.update_attributes(position: index+1)
      end
    end
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
  
