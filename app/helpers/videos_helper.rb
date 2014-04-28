module VideosHelper
  def video_is_in_my_queue
    QueueItem.find_by(user: current_user, video: @video) 
  end
end
