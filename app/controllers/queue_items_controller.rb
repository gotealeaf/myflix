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
      current_user.normalize_queue_positions()
      flash[:success] = "#{video_title} was removed from your queue"
    end
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_positions
      flash[:success] = "Your Queue Items have been updated."
    rescue
      flash[:danger] = "Invalid positions for queue items."
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

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:items].each do |qi_data|
        qi = QueueItem.find(qi_data['id'])
        qi.update_attributes!(position: qi_data['position'], rating: qi_data['rating']) if qi.user == current_user
      end
    end
  end
  
end
