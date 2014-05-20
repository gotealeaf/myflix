class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).order(created_at: :desc).first
    review.rating if review
  end
  
end
