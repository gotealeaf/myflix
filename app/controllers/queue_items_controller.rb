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

  def destroy
    queue_item = QueueItem.find(params[:id])
    video_title = queue_item.video.title
    if current_user.queue_items.include?(queue_item)
      queue_item.destroy
      flash[:success] = "#{video_title} was removed from your queue"
    end
    redirect_to my_queue_path
  end
  
  def update
    @items = pull_and_sort_items(params[:items])
    flash[:success] = "Your Queue Items have been updated." if update_sorted_items(@items)
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
  
  def pull_and_sort_items(items_array)
    item_objects = []
    sorted = items_array.sort_by {|item| item['position'] }
    sorted.each do |item|
      item = QueueItem.find(item['id'])
      item_objects.push(item)
    end
    return item_objects
  end
  
  def update_sorted_items(item_objects)
    item_objects.each_with_index do |item,index|
      item.position = index + 1
    end
    QueueItem.transaction do
      item_objects.each do |item|
        item.save!
      end
    end
    return true
  end
  
end
