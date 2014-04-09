class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
    render 'users/my_queue'
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = QueueItem.new(video: video, user: current_user, position: user_next_queue_position)

    if queue_item.save  
      redirect_to my_queue_path
    else
      flash[:warning] = "This video has already been added to your queue."
      redirect_to video
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user == queue_item.user
    redirect_to my_queue_path
  end

  def update_queue
    current_user.queue_items.each do |queue_item|
      queue_item.position = params[queue_item.id.to_s]

      if queue_item.position > current_user.queue_items.count
        QueueItem.where(user: current_user).each do |queue_item|
          queue_item.position = queue_item.position - 1
          queue_item.save
        end

        queue_item.position = current_user.queue_items.count
      end
      queue_item.save
    end

    redirect_to my_queue_path
  end

  private

  def user_next_queue_position
    current_user.queue_items.count + 1
  end
end