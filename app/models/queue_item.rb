class QueueItem < ActiveRecord::Base 
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :order, { only_integer: true }

  def rating
    review = Review.find_by(user_id: user.id, video_id: video.id)
    review.nil? ? nil : review.rating
  end

  def category_name
    category.name
  end
end

