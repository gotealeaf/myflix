require "pry"

class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    @queue_item = QueueItem.new(video: @video, user: current_user, position: queue_position)

    if @queue_item.save
      flash[:notice] = "Video added to your queue!"
      redirect_to my_queue_path
    else
      flash[:error] = "Video already in your queue."
      redirect_to video_path(@video)
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    normalize_position
    redirect_to my_queue_path
  end

  def update_queue 
    begin
      update_position
      normalize_position
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid input to update queue position."
    end  
    redirect_to my_queue_path  
  end

  private

  def queue_position
    current_user.queue_items.count + 1
  end

  def queue_item_params
    params.require(:queue_item).permit(:position)
  end

  def update_position
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |data|
        queue_item = QueueItem.find(data[:id])
        queue_item.update_attributes!(position: data[:position]) if queue_item.user == current_user
      end
    end
  end

  def normalize_position
    current_user.queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end 
  end
end




  