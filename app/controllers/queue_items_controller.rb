class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id]) if params[:video_id]

    if video
      QueueItem.create(user: current_user, video: video, position: QueueItem.next_available_position(current_user))
      flash[:success] = "#{video.title} was successfully added to your queue."
    else
      flash[:danger] = 'There was a problem adding the video to your queue. Please try again.'
    end

    redirect_to :back
  end

  def destroy
    if current_user == QueueItem.find(params[:id]).user
      QueueItem.destroy(params[:id])
      flash[:success] = 'The video was successfully removed from your queue.'
    else
      flash[:danger] = 'There was a problem removing the video from your queue.'
    end
    redirect_to :back
  end

  def update_queue
    if positions_are_valid?
      params[:queue_items].each do |item_data|
        queue_item = QueueItem.find(item_data[:id])
        queue_item.update_attributes!(position: item_data[:position], rating: item_data[:rating]) if current_user == queue_item.user
      end

      current_user.normalize_queue_positions

      flash[:success] = 'You have successfully updated your queue.'
    else
      flash[:danger] = 'There was a problem updating your queue. Please try again.'
    end

    redirect_to :back
  end

  private

  def positions_are_valid?
    params[:queue_items].map{|item|item[:position]}.select{|position|!(position =~ /\A\d+\z/)}.empty?
  end
end
