class QueueItemsController < ApplicationController  
  before_action :require_user, only: [:index, :destroy]

  def index
    @queue_items = current_user.queue_items
  end

  # def destroy
  #   queue_items(params[:id]).destroy
  #   redirect_to my_queue_path
  # end
end