class QueueItemsController < ApplicationController
  before_filter :authorize

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    if current_user_queue_video?(@video)
      flash[:info] = "#{@video.title} was already in your queue."
    else
      if queue_video(@video)
        flash[:success] = "#{@video.title} was added to your queue"
      else
        flash[:error] = "There was an error adding #{@video.title} to your queue."
      end
    end
    redirect_to my_queue_path
  end

  private

  def queue_video(video)
      QueueItem.create(video:@video,user:current_user, position: new_queue_item_position)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queue_video?(video)
    current_user.queue_items.map(&:video).include?(@video)
  end
end
