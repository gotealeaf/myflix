  class QueueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find_by_id(params[:video_id])
    QueueItem.create(video: video, user: current_user, position: current_user.queue_items.count + 1) unless current_user.queue_items.map { |n| n.video }.include?(video)
    redirect_to queue_items_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy
    redirect_to queue_items_path
  end

  def sort
    queue_items = params[:queue_items]
    #binding.pry
    queue_items.each_with_index do |id, index|
      QueueItem.where({position: index+1}, {id: id}).to_a
    end
    redirect_to(queue_items_path)    
  end

end