class QueueItemsController < ApplicationController
  before_filter :authorize

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    @queue_item = QueueItem.new(video:@video,user:current_user)
    if @queue_item.save
      flash[:success] = "#{@video.title} was added to your queue"
    end
    redirect_to video_path(@video)
  end
end
