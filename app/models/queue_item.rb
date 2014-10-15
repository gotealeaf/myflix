class QueueItem < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :video
  
  delegate :title, to: :video, prefix: :video
  
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
  
end