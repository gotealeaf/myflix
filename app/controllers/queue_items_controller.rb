class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
    render 'users/my_queue'
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = QueueItem.new(video: video, user: current_user, position: user_next_queue_position)

    if queue_item.save  
      redirect_to my_queue_path
    else
      flash[:warning] = "This video has already been added to your queue."
      redirect_to video
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user == queue_item.user
    current_user.normalize_queue_items_positions
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_items_positions
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Invalid position entry."
    end

    redirect_to my_queue_path
  end

  private

  def user_next_queue_position
    current_user.queue_items.count + 1
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update!(position: queue_item_data[:position], rating: queue_item_data[:rating]) if queue_item.user == current_user
      end
    end
  end
end