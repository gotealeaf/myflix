class QueueItemsController < ApplicationController
  before_action :signed_in_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @queue_items = current_user.queue_items
    @queue_item = @queue_items.new(video_id: params[:video_id], ranking: @queue_items.count )
    if @queue_item.save
      redirect_to my_queue_path
    else
      render "videos#show"
    end
  end
end
