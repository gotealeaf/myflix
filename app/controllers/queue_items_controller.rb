class QueueItemsController < ApplicationController
  before_action :current_user, :authorize

  def index
    @queue_items = QueueItem.all
  end

  def create
    video = Video.find_by(params[:video_id])
    QueueItem.create(video: video, user: current_user) unless current_user.queue_items.map(&:video).include?(video)
    redirect_to queue_items_path
  end

end