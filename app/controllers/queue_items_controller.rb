class QueueItemsController < ApplicationController   
  before_filter :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video video 
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if queue_item.user == current_user
      queue_item.destroy
      current_user.normalize_queue_positions
    end
    
    redirect_to my_queue_path
  end

  def update_queue  
    begin
      update_queue_items
      current_user.normalize_queue_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "The input must be only integer numbers."
    end
    
    redirect_to my_queue_path
  end

  private 

  def queue_video video
    QueueItem.create(video: video, user: current_user, order: new_queue_item_order) unless current_user_has_video?(video)   
  end

  def new_queue_item_order
    current_user.queue_items.count + 1
  end

  def current_user_has_video? video
    current_user.queue_items.map(&:video).include?(video)    
  end

  def update_queue_items 
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |input|
        update_queue_items_order input
        create_review input
        # update_queue_items_rating input 
      end
    end
  end

  def update_queue_items_order input
    queue_item = QueueItem.find_by(id: input[:id])
    queue_item.update_attributes!(order: input[:order]) if queue_item.user == current_user
  end

  def create_review input
    Review.create(creator: current_user, video: QueueItem.find_by(id: input[:id]).video, rating: input[:rating])
  end

  def update_queue_items_rating input
    review = Review.find_by(creator: current_user, video: QueueItem.find_by(id: input[:id]).video)
    review.update_attributes!(rating: input[:rating])
  end
end