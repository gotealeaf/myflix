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
    redirect_to my_queue_path
  end

  def update_queue
    params_array = params[:queue_items]

    if moved_item_id = find_greater_then_total_id(params_array)
      params_array = rearange(moved_item_id, params_array)
    end

    if param_positions_valid?(params_array)
      set_positions(params_array)
    else
      flash[:warning] = "Please number each queue item 1 to #{user_queue_total}."
    end

    redirect_to my_queue_path
  end

  private

  def user_queue_total
    current_user.queue_items.count
  end

  def user_next_queue_position
    user_queue_total + 1
  end

  def find_greater_then_total_id(params_array)
    params_array.each do |params_hash|
      return params_hash[:id].to_i if params_hash[:position].to_i > user_queue_total
    end
    return false
  end

  def rearange(moved_item_id, params_array)
    moved_postion = QueueItem.find(moved_item_id).position
    params_array.map! do |params_hash|
      params_hash[:position] = params_hash[:position].to_i - 1 if params_hash[:position].to_i > moved_postion
      params_hash
    end
  end

  def param_positions_valid?(params_array)
    params_array.map{ |i| i[:position].to_i }.sort == [*1..user_queue_total].sort
  end

  def set_positions(params_array)
    params_array.each do |params_hash|
      queue_item = QueueItem.find(params_hash[:id].to_i)
      queue_item.position = params_hash[:position]
      queue_item.save
    end
  end
end