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
        flash[:danger] = "There was an error adding #{@video.title} to your queue."
      end
    end
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    video_title = queue_item.video.title
    if current_user.queue_items.include?(queue_item)
      queue_item.destroy
      QueueItem.normalize_item_positions_for_user(current_user)
      flash[:success] = "#{video_title} was removed from your queue"
    end
    redirect_to my_queue_path
  end
  
  def update
    @qitems = QueueItem.assign_positions_for_user(current_user,params[:items])
    if QueueItem.save_positions_for_user(current_user,@qitems)
      flash[:success] = "Your Queue Items have been updated." 
    else
      flash[:danger] = "Invalid positions for queue items." 
    end
    redirect_to my_queue_path
  end

  private

  def queue_video(video)
      QueueItem.create(video:@video,user:current_user)
  end

  def current_user_queue_video?(video)
    current_user.queue_items.map(&:video).include?(@video)
  end
  
end
