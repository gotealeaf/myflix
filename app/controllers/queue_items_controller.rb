class QueueItemsController < ApplicationController
  before_action :require_user

  def create
    @qitem = QueueItem.new(queue_params)
    @qitem.user_id = session[:user_id]
    @exist = is_previous_item?
    if is_previous_item?
      flash[:danger] = "You already have this video queued."
      if @qitem[:position] != nil
        if same_position?
          @same_position = true
          flash[:danger] = 'Your item is already queued in the same position, it will not be updated'
        else
          update_position
          save_qitem
        end
      else
        select_last_position(@qitem)
        flash[:success] = "Your item has queue number #{@qitem[:position]}"
        save_qitem
      end
    end
    if @qitem.errors?
      flash[:danger] = "Your item failed to save."
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

  def select_last_position(array)
    number_to_set = @check_video.count + 1
    @qitem[:position] = number_to_set
  end

  def save_qitem
    @qitem.save
    true
  end

  def update_position
    @check_video.update_all(position: params[:qitem][:position].to_i)
  end

end
