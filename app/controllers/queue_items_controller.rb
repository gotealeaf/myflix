class QueueItemsController < ApplicationController
  before_action :require_user

  def create
    @qitem = QueueItem.new(queue_params)
    @qitem.user_id = session[:user_id]
    @exist = is_previous_item?
    if is_previous_item?
      flash[:danger] = "You already have this video queued."
      if same_position?
        @same_position = true
        flash[:danger] = 'Your item is already queued in the same position, it will not be updated'
      else
        update_position
      end
    end
    redirect_to queue_items_path
  end

  private

  def queue_params
    params.require(:qitem).permit(:user_id, :video_id, :position)
  end

  def is_previous_item?
    @check_video = QueueItem.where(video_id: params[:qitem][:video_id].to_i, user_id: session[:user_id])
    !@check_video.blank? #returns true if there is a video matching
  end

  def same_position?
    check_video = QueueItem.where(video_id: params[:qitem][:video_id].to_i, user_id: session[:user_id], position: params[:qitem][:position])
    !check_video.blank? #returns true if there is a video matching
  end

  def update_position
    binding.pry
    @check_video.update(position: params[:qitem][:position])
  end

end
