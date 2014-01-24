class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    queue_video(@video)
    redirect_to queue_items_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to queue_items_path
  end

  private

  def queue_video(video)
    @queue_item = @video.queue_items.create(user: current_user, ranking: new_queue_item_ranking) unless current_user_queued_video?(@video) 
  end

  def new_queue_item_ranking
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    @video.queue_items.find_by_user_id(current_user.id)
  end
end