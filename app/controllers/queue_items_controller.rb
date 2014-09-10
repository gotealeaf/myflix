class QueueItemsController < ApplicationController
  before_filter :logged_in?

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find_by_id(params[:video_id])
    QueueItem.create(video: video, user: current_user, position: current_user.queue_items.count + 1) unless queued_video_for_current_user?(video)
    redirect_to my_queue_path
  end
  
  def update
    @queue_items = params[:queue_items]
    update_all_queue_items params[:queue_items]
    redirect_to my_queue_path
  end
  
  def destroy
    qi = QueueItem.find_by_id(params[:id])
    qi.destroy unless (qi.blank? || qi.user != current_user )
    redirect_to my_queue_path
  end

private

  def queued_video_for_current_user? video
    QueueItem.where(video_id: video.id, user_id: current_user.id).count > 0
  end

  def update_all_queue_items qi
    #wrap in transaction because positions are related to each other
    ActiveRecord::Base.transaction do
      qi.each do |q|
        queue_item = current_user.queue_items.select{|i| q[:id] == i.id.to_s}
        if queue_item.first.present?
          queue_item.first.position = q[:position].to_i
          queue_item.first.save
        else
          #if item doesn't belong to user, roll back everything
          raise ActiveRecord::Rollback
          return;
        end
      end
    end
  end    

end
