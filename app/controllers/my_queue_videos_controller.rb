class MyQueueVideosController < ApplicationController 
  before_action :require_user
  def index
    # binding.pry
    @videos = current_user.my_queue_videos
  end

  def create
    item = MyQueueVideo.find_by(video_id: params[:video_id], user_id: current_user.id)
    video = Video.find(params[:video_id])
    newitem = MyQueueVideo.new( video_id: params[:video_id], user_id: current_user.id, index: current_user.queue_size + 1 ) if item.nil?
    if item.nil? && newitem.save
      redirect_to my_queue_path
    else
        redirect_to :back
    end
  end

  def destroy    
    queue_video = MyQueueVideo.find(params[:id])
    queue_video.destroy unless queue_video.nil? 
    redirect_to my_queue_path
  end

  def update_queue_videos
    redirect_to my_queue_videos_path
  end

end