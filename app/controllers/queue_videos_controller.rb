class QueueVideosController < ApplicationController
  before_action :require_user

  def index
    @queue_videos = current_user.queue_videos
  end

  def create
    unless video_in_queue
      QueueVideo.create(video_id: params[:video_id], user: current_user, position: queue_position)
    end
    redirect_to my_queue_path
  end

  def destroy
    @queue_video = QueueVideo.find_by(user: current_user, id: params[:id])
    @queue_video.destroy if video_present
    current_user.normalise_queue_positions
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_videos
      current_user.normalise_queue_positions
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position inputs"
    end
    redirect_to my_queue_path
  end

  private

  def video_present
    @queue_video.present?
  end

  def queue_position
    QueueVideo.maximum(:position).to_i + 1
  end

  def video_in_queue
    QueueVideo.find_by(video_id: params[:video_id])
  end

  def update_queue_videos
    QueueVideo.transaction do
      user_inputs = params[:queue_videos]
      user_inputs.each do |queue_video|
        QueueVideo.find(queue_video[:id]).update_attributes!(position: queue_video[:position], rating: queue_video[:rating])
      end
    end
  end

end
