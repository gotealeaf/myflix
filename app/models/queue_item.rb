class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :position, numericality: { only_integer: true }

  def video_title
    video.title
  end

  def category_name
    video.category.name
  end

  def video_rating
    review = video.reviews.where(user: user, video: video).first
    review.rating if review
  end
end