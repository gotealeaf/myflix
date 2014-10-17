class QueueItem < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :video
  
  delegate :title, to: :video, prefix: :video
  
  validates_numericality_of :position, {only_integer: true}
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end
  
  def category_name
    video.categories.first.name
  end
  
  def category
    video.categories.first
  end
  
  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: new_queue_item_position) unless current_user_queued_video?(video)
  end
  
  def new_queue_item_position
    current_user.queue_items.count + 1
  end
  
  def current_user_queued_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
  
  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update_attributes!(position: queue_item_data[:position]) if queue_item.user == current_user
      end
    end
  end
  
  def normalize_queue_item_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end
  
end