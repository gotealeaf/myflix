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
    normalize_queue_items_positions
    redirect_to my_queue_path
  end

  def update_queue
    params_array = params[:queue_items]

    begin
      update_queue_items
      normalize_queue_items_positions
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
      params[:queue_items].each do |queue_items_data|
        queue_item = QueueItem.find(queue_items_data[:id].to_i)
        queue_item.update!(position: queue_items_data[:position]) if queue_item.user == current_user
      end
    end
  end

  def normalize_queue_items_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end
end