class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  validates_numericality_of :list_order, {only_integer: true}
  
  def video_title
    video.title
  end
  
  def category_names
    video.categories 
  end
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first #note temporary
    review.rating if review
  end
  
end