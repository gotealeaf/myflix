class QueueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @queue_items = QueueItem.all
  end

  def create
    @video = Video.find_by(params[:video_id])
    queue_item = QueueItem.create(queue_item_params.merge!(user_id: current_user, video_id: @video)).reload unless QueueItem.where(video_id: @video, user_id: current_user).first
    redirect_to queue_items_path
  end

  private

  def queue_item_params
    params.permit(:video_id, :user_id)
  end

end