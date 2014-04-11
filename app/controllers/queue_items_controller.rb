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
    update_queue_items(params[:queue_items])
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if queue_item.user_id == current_user.id
      queue_item.destroy 
      normalize_queue_items
    end
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.length + 1
  end

  def update_queue_item_positions deleted_position
    current_user.queue_items.each do |queue_item|
      if queue_item.position > deleted_position.to_i
        queue_item.update_column(:position, queue_item.position - 1) 
      end
    end
  end

  def update_queue_items(new_queue_positions)
    if (all_queue_positions_integers?(new_queue_positions) && 
        all_queue_positions_unique?(new_queue_positions) && 
        all_queue_items_belong_to_user?(new_queue_positions))
      new_queue_positions.each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id].to_i)
        queue_item.update_attributes(position: queue_item_data[:position].to_i)
      end

      normalize_queue_items

    elsif !all_queue_positions_integers?(new_queue_positions)
      flash[:danger] = "Non-integer order numbers entered"
    elsif !all_queue_positions_unique?(new_queue_positions)
      flash[:danger] = "Non-unique order numbers entered"
    end
  end

  def normalize_queue_items
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def all_queue_positions_integers?(new_queue_positions)
    new_queue_positions.each do |queue_item|
      unless queue_item[:position] == queue_item[:position].to_i.to_s
        return false
      end
    end
    true
  end

  def all_queue_positions_unique?(new_queue_positions)
    positions = []
    new_queue_positions.each do |queue_item|
      positions << queue_item[:position]
    end
    positions.uniq.length == positions.length
  end

  def all_queue_items_belong_to_user?(new_queue_positions)
    new_queue_positions.each do |queue_item|
      unless QueueItem.find(queue_item[:id]).user == current_user
        return false
      end
    end
    true
  end
end