  class QueueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @queue_items = current_user.queue_items
    @review = Review.new
  end

  def create
    video = Video.find_by_id(params[:video_id])
    QueueItem.create(video: video, user: current_user, position: current_user.queue_items.count + 1) unless current_user.queue_items.map { |n| n.video }.include?(video)
    redirect_to queue_items_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to queue_items_path
    current_user.repositions_queue_items
  end

  def sort
    
    begin
      ActiveRecord::Base.transaction do
        update_queue_item_position
      end
    rescue ActiveRecord::RecordInvalid
      flash_error_message
      return
    end
    current_user.repositions_queue_items
    redirect_to(queue_items_path)
  end

  private

  def update_queue_item_position
    params[:queue_items].each do |queue_item_data|
      queue_item = QueueItem.find(queue_item_data["id"])
      queue_item.update!(position: queue_item_data["position"], review_rating: queue_item_data["rating"]) if queue_item.user == current_user
    end
  end

  def flash_error_message
    flash[:notice] = "Please only use whole numbers to update the queue" 
    redirect_to queue_items_path
  end
end