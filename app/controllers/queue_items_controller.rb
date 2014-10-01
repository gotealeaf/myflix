class QueueItemsController < ApplicationController
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    add_video = Video.find(params[:video_id])
    queue_video(add_video)
    redirect_to my_queue_path
  end

  def destroy
    item = QueueItem.find(params[:id])

    if item.user == current_user
      item.destroy
      current_user.normalize_queue_item_positions
    end
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position number"
    end
    redirect_to my_queue_path
  end

  private

  def update_queue_items
    ActiveRecord::Base.transaction do 
      params[:queue_items].each do |item|
        queue_item = QueueItem.find(item["id"])
        if queue_item.user == current_user
          queue_item.update_attributes!(position: item["position"], rating: item["rating"])
        end
      end
    end
  end

  def queue_video(video)
    unless queue_item_exists?(video)
      QueueItem.create(position: new_queue_item_position, video: video, user: current_user)
    end
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def queue_item_exists?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end