class QueueVideosController < ApplicationController
  before_action :require_user
  def index
    # QueueVideo.where(user: current_user)
    @queue_videos = current_user.queue_videos
  end
end
