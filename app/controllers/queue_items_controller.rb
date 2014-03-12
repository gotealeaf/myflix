class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    current_user.queue_video(video)
    redirect_to queue_items_path
  end

  def update_queue_list
    begin
      update_each_queue_item
      current_user.renumber_queue
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "You must enter only whole numbers."
    end
    redirect_to queue_items_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    current_user.renumber_queue
    redirect_to queue_items_path
  end

  private

  def update_each_queue_item
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |data|
        queue_item = QueueItem.find data[:id]
        queue_item.update_attributes!(ranking: data[:ranking], rating: data[:rating]) if current_user == queue_item.user
      end
    end
  end
end