class QueueItemsController < ApplicationController
  before_action :require_user, :current_user
  def index
    @queue_items = get_queue_items_for_user
    render
  end

  def create
    @queue_item = QueueItem.new(queue_item_params)
    if is_video_already_in_queue?
      flash[:danger] = 'This video is already in your queue. It will not be saved.'
      redirect_to my_queue_path
    else
      save_queue_item
      flash[:success] = "The video has been added to the queue."
      redirect_to my_queue_path
    end
  end

  def update_order
    begin
      ActiveRecord::Base.transaction do
        queue_items = params[:queue_items]
        find_video_for(queue_items)
        update_attributes(queue_items)
        binding.pry
        current_user.normalise_queue
        flash[:success] = "The order of the videos in your queue has been updasted."
      end
      redirect_to my_queue_path
    rescue
      flash[:danger] = "There was an error saving your queue items."
      redirect_to my_queue_path
    end
  end

  def destroy
    if queue_item_belong_to_user?
      QueueItem.delete(params[:id])
      flash[:success] = "The video was successfully removed from your queue."
      current_user.normalise_queue
    else
      flash[:danger] = "There was an error removing the video from your queue. Please try again."
    end
    redirect_to my_queue_path
  end

  private

  def save_queue_item
    @queue_item[:position] = set_position
    @queue_item.save
  end

  def validates_position_is_integer(position)
    position.select{|item|item[/(\.|\s|0|\D)/]}
  end

  def find_video_for(queue_items)
    queue_items.each do |queue_item|
      final_queue_item = get_queue_item(queue_item)
      review = Review.where(user: current_user, video: final_queue_item.video).first
      review.update_review_attributes(queue_item)
    end
  end

  def update_attributes(queue_items)
    queue_items.each do |queue_item|
      final_item = get_queue_item(queue_item)
      if final_item.user == current_user
        final_item.update_queue_item_attributes(queue_item)
      else
        raise "The user is trying to alter queue items they do not own."
      end
    end
  end

  def get_queue_item(queue_item)
    QueueItem.find(queue_item[:id])
  end

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

  def is_video_already_in_queue?
    QueueItem.get_queue_items_for_video_and_user(queue_item_params[:video_id], queue_item_params[:user_id]).any?
  end

  def queue_item_params
    params.require(:qitem).permit(:position, :video_id, :user_id)
  end
end
