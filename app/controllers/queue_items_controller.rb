class QueueItemsController < ApplicationController  
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    queue_item = QueueItem.new(video: Video.find(params[:video_id]), user: current_user, 
                               position: new_queue_item_position)
    unless queue_item.save
      flash[:danger] = queue_item.errors.full_messages
    end
    redirect_to my_queue_path
  end

  # def destroy
  #   queue_items(params[:id]).destroy
  #   redirect_to my_queue_path
  # end

  private

  def new_queue_item_position
    current_user.queue_items.length + 1
  end
end