class MyQueueVideosController < ApplicationController 
  before_action :require_user
  def index
    @videos = current_user.my_queue_videos
  end
end