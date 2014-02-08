class QueueItemsController < ApplicationController
 
   before_action :require_user

   helper_method :already_queued?

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video) unless already_queued?(video)
    redirect_to my_queue_path 
  end

  def update_queue
    unless params[:queue_items].nil?
      begin
        update_queue_items
        current_user.normalize_queue_item_positions
      rescue  ActiveRecord::RecordInvalid
        flash[:error] = "Invalid position numbers"
      end
    end
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy
    current_user.normalize_queue_item_positions
    redirect_to my_queue_path
  end

  def already_queued?(video)
   current_user.has_queued_video?(video)
  end
 
  private  

  def last_place
    current_user.queue_items.count + 1
  end

  def queue_video(video)
    QueueItem.create(position: last_place, video: video, user: current_user)  
  end 

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each  do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        if queue_item.user == current_user
          queue_item.update_attributes!(position: queue_item_data["position"], rating: queue_item_data["rating"]) 
        end
      end
    end
  end
end
  
