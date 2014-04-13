class QueueItemsController < ApplicationController  
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    queue_item = QueueItem.new(video: Video.find(params[:video_id]), 
                               user: current_user, 
                               position: new_queue_item_position)
    unless queue_item.save
      flash[:danger] = queue_item.errors.full_messages
    end
    redirect_to my_queue_path
  end

  def update_queue
    #binding.pry
    update_queue_item_positions(params[:queue_items])
    current_user.normalize_queue_item_positions
    #update_queue_item_ratings(params[:queue_items])
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if queue_item.user_id == current_user.id
      queue_item.destroy 
      current_user.normalize_queue_item_positions
    end
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.length + 1
  end

  def update_queue_item_positions(new_queue_values)
    if (all_queue_positions_valid?(new_queue_values))
      new_queue_values.each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id].to_i)
        queue_item.update_attributes(position: queue_item_data[:position].to_i, rating: queue_item_data[:rating].to_i) if queue_item.user == current_user
      end
    elsif !all_queue_positions_integers?(new_queue_values)
      flash[:danger] = "Non-integer order numbers entered"
    elsif !all_queue_positions_unique?(new_queue_values)
      flash[:danger] = "Non-unique order numbers entered"
    end
  end

  def all_queue_positions_valid?(new_queue_values)
    (all_queue_positions_integers?(new_queue_values) && 
    all_queue_positions_unique?(new_queue_values))
  end

  def all_queue_positions_integers?(new_queue_values)
    new_queue_values.each do |queue_item|
      return false unless queue_item[:position] == queue_item[:position].to_i.to_s
    end
    true
  end

  def all_queue_positions_unique?(new_queue_values)
    positions = []
    new_queue_values.each do |queue_item|
      positions << queue_item[:position]
    end
    positions.uniq.length == positions.length
  end
end