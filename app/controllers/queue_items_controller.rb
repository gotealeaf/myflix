class QueueItemsController < ApplicationController
  before_action :require_user, :current_user

  def show
    @queue_items = get_queue_items_for_user
    render
  end

  def create
    @queue_item = QueueItem.new(queue_item_params)
    if is_video_already_in_queue? == true
      flash[:danger] = 'This video is already in your queue. It will not be saved.'
      redirect_to my_queue_path
    else
      @queue_item[:position] = set_position
      @queue_item.save
      flash[:success] = "The video has been added to the queue."
      redirect_to my_queue_path
    end
  end

  private

  def number_of_queue_items
    get_queue_items_for_user.count
  end

  def set_position
    number_of_queue_items + 1
  end

  def get_queue_items_for_user
    current_user.queue_items
  end

  def is_video_already_in_queue? #true if already in queue
    items = QueueItem.get_queue_items_for_video_and_user(queue_item_params[:video_id], queue_item_params[:user_id])
    !items.blank? #returns true if there are videos
  end

  def queue_item_params
    params.require(:qitem).permit(:position, :video_id, :user_id)
  end

end
