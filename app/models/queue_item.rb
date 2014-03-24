class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :position, numericality: { only_integer: true }

  def rating=(new_rating = nil)
    review = Review.where(user: user, video: video, rating: new_rating).first
    review.update(rating: new_rating)
  end

  def video_rating
    review = Review.where(user: user, video: video).first
    review.rating if review
  end

  def video_title
    video.title
  end

  def category_name
    video.category.name
  end
end