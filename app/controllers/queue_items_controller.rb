class QueueItemsController < ApplicationController   
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def add_to_queue
    if QueueItem.find_by(user: current_user, video: Video.find(params[:id])).nil?
      QueueItem.create(user: current_user, video: Video.find(params[:id]))
      flash[:notice] = "The video has been added to your queue."
      redirect_to video_path  
    else
      flash[:error] = "The video is allready in your queue."  
      render 'videos/show'
    end      
  end
end