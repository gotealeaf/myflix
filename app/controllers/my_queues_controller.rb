class MyQueuesController < ApplicationController   
  before_action :require_user
  before_action :set_my_queue

  def show    
    @my_queue_videos = @queue.my_queue_videos
  end  
  
  
  def set_my_queue
    @queue = current_user.my_queue 
  end

end