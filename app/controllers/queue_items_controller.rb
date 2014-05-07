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
    current_user.normalize_queue_item_list_order
    redirect_to my_queue_path
  end
  
  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_item_list_order
    rescue ActiveRecord::RecordInvalid #this will rollback the database
      flash[:danger] = "Invalid position numbers."
    end
    redirect_to my_queue_path
  end
  
  private
  
  def new_queue_item_position
    current_user.queue_items.count + 1
  end
  
  def current_user_queued_items?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
  
  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data| # note: not moving this to model layer as params (with the form) is tied closely to what a controller should do
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(list_order: queue_item_data["list_order"], rating: queue_item_data["rating"]) 
        end
      end
  end 
end