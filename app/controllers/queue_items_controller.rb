class QueueItemsController < ApplicationController
  before_action :require_signed_in, only: [:index, :destroy]
  before_action :require_owner,     only: [:destroy]

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video      = Video.find_by(params[:video_id])
    @queue_item = QueueItem.create(video_id: params[:video_id],
                                   user: current_user,
                                   position: next_position)
    if @queue_item.valid?
      flash[:notice] = "Video added to your queue."
      redirect_to my_queue_path
    else
      flash[:error] = "Video is already in your queue."
      redirect_to @video
    end
  end

  def destroy
    QueueItem.find(params[:id]).destroy
    redirect_to my_queue_path
  end

  private
    def next_position
      (current_user.queue_items.count)+1
    end

    def require_owner
      redirect_to root_path unless (queue_owner == current_user)
    end

    def queue_owner
      QueueItem.find(params[:id]).user
    end
end
