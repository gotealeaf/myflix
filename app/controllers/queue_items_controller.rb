class QueueItemsController < ApplicationController
  before_action :signed_in_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video)
    redirect_to my_queue_path
  end


  private
    def queue_video(video)
      unless has?(video)
        current_user.queue_items.create(video: video, ranking: new_item_position)
      end
    end

    def has?(video)
      current_user.queue_items.map(&:video).include?(video)
    end

    def new_item_position
      current_user.queue_items.count + 1
    end
end
