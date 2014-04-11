class QueuesController < ApplicationController
  before_action :require_user, only: [:create, :destroy]
  def create
    queue_target  = ( QueueItem.where(user: current_user).count + 1  )
    @queue_item = QueueItem.create(
      video: Video.find( params[:video_id] ),
      user: User.find( params[:user_id] ),
      position: queue_target
    ) 
    redirect_to my_queue_path
  end

  def index; end

  def destroy
   @queue_item =  QueueItem.find(params[:id])
   @queue_item.destroy if @queue_item.user == current_user
    redirect_to my_queue_path
  end
end
