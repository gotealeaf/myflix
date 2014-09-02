class QueueItemsController < ApplicationController
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    add_video = Video.find(params[:video_id])
    queue_video(add_video)
    redirect_to my_queue_path
  end

  private

  def queue_video(video)
    unless queue_item_exists?(video)
      QueueItem.create(position: new_queue_item_position, video: video, user: current_user)
    end
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def queue_item_exists?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end