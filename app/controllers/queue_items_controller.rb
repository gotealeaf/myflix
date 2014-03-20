class QueueItemsController < ApplicationController  
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    queue_item = QueueItem.new(video_id: params[:video_id], user_id: current_user.id)
    queue_item.position = current_user.queue_items.length + 1
    unless queue_item.save
      flash[:danger] = "That video is already in your queue"
    end
    redirect_to my_queue_path
  end

  # def destroy
  #   queue_items(params[:id]).destroy
  #   redirect_to my_queue_path
  # end

  #private

  # def queue_item_params
  #   params.require(:queue_item).permit(:video_id)
  # end
end