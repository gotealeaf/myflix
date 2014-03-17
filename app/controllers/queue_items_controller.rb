class QueueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @queue_items = QueueItem.all
  end

  def create
    @video = Video.find_by(params[:video_id])
    QueueItem.create(video: @video, user: current_user).reload unless QueueItem.where(video: @video, user: current_user).first
    redirect_to queue_items_path
  end

end