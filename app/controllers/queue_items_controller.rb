class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    @queue_item = QueueItem.new(video: @video, user: current_user, position: queue_position)

    if @queue_item.save
      flash[:notice] = "Video added to your queue!"
      redirect_to my_queue_path
    else
      flash[:error] = "Video already in your queue."
      redirect_to video_path(@video)
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to my_queue_path
  end

  private

  def queue_position
    current_user.queue_items.count + 1
  end
end

  