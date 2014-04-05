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
    if queue_item.user == current_user
      queue_item.destroy
      normalize_queue_positions
    end
    
    redirect_to my_queue_path
  end

  def update_queue  
    begin
      update_queue_items
      normalize_queue_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "The input must be only integer numbers."
    end
    
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

  def update_queue_items
    QueueItem.transaction do
      params[:queue_items].each do |updated_element|
          queue_item = QueueItem.find_by(id: updated_element[:id])
          queue_item.update_attributes!(order: updated_element[:order]) if queue_item.user == current_user
      end
    end    
  end

  def normalize_queue_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index + 1)
    end    
  end
end