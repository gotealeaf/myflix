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
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to queue_items_path
  end

  def sort
    begin
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |queue_item_data|
          queue_item = QueueItem.find(queue_item_data["id"])
          queue_item.update!(position: queue_item_data["position"]) if queue_item.user == current_user
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:notice] = "Please only use whole numbers to update the queue" 
      redirect_to queue_items_path
      return
    end

    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index+1)
    end

    redirect_to(queue_items_path)
    
  end

end