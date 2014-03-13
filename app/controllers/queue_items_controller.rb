class QueueItemsController < ApplicationController
  before_action :require_user, :current_user
  def index
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

  def update_order
    queue_items = params[:queue_items]
    positions = queue_items.map { |e| e[:position]}
    non_valid_items = positions.select{|item|item[/(\.| |0|\D)/]}
    if non_valid_items != []
      flash[:danger] = "There was a problem updating your queue. Please try again using only whole numbers."
    else
      queue_items.each do |queue_item|
        queue_item_found = QueueItem.find(queue_item[:id])
        if queue_item_found.user_id == session[:user_id]
          queue_items.each do |queue_item|
            QueueItem.find(queue_item[:id]).update_attribute(:position, queue_item[:position])
          end
          @queue_count = 0
          current_user.queue_items.each do |queue_item|
            @queue_count = @queue_count + 1
            QueueItem.find(queue_item[:id]).update_attribute(:position, @queue_count)
          end
          flash[:success] = "The order of the videos in your queue has been updasted."
        else
          flash[:danger] = "There was an error updating your queue item. Please try again."
        end
      end
    end
    redirect_to my_queue_path
  end

  def destroy
    if queue_item_belong_to_user?
      QueueItem.delete(params[:id])
      flash[:success] = "The video was successfully removed from your queue."
    else
      flash[:danger] = "There was an error removing the video from your queue. Please try again."
    end
    redirect_to my_queue_path
  end

  private

  def number_of_queue_items
    get_queue_items_for_user.count
  end

  def queue_item_belong_to_user?
    QueueItem.where(id: params[:id], user_id: session[:user_id]).any?
  end

  def set_position
    number_of_queue_items + 1
  end

  def get_queue_items_for_user
    current_user.queue_items
  end

  def is_video_already_in_queue? #true if already in queue
    QueueItem.get_queue_items_for_video_and_user(queue_item_params[:video_id], queue_item_params[:user_id]).any?
  end

  def queue_item_params
    params.require(:qitem).permit(:position, :video_id, :user_id)
  end
end
