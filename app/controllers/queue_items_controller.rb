class QueueItemsController < ApplicationController   
  before_filter :require_user
  def index
    @queue_items = current_user.queue_items
  end

  def add_to_queue
    QueueItem.create(user: current_user, video: Video.find(params[:id]))
    redirect_to "video/show"
  end

end