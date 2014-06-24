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

  private

  def queue_position
    current_user.queue_items.count + 1
  end
end

  