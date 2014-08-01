class QueueItemsController < ApplicationController
  before_action :signed_in_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:id])
    queue(video.id)
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_item
      current_user.reset_order_ranking
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Invalid number for ranking."
      redirect_to my_queue_path and return
    end

    redirect_to my_queue_path
  end

  def destroy
    item = QueueItem.find(params[:id])
    item.destroy if item.creator == current_user
    current_user.reset_order_ranking
    redirect_to my_queue_path
  end

  private
    def queue(video_id)
      unless current_user.queued?(video_id)
        current_user.queue_items.create(video_id: video_id, ranking: new_position)
      end
    end

    def update_item
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |item_data|
          item = QueueItem.find(item_data[:id])
          item.update!(ranking: item_data[:ranking], rating: item_data[:rating]) if item.creator == current_user
        end
      end
    end

    def new_position
      current_user.queue_items.count + 1
    end
end
