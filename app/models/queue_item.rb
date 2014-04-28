class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_uniqueness_of :video, scope: :user

  def category_name
    video.category.name
  end

  def rating
    video.reviews.find_by(user: user).try(:rating)
  end

  def save_rating(value)
    review = video.reviews.find_by(user: user)
    review.rating = value
    review.save(validate: false)
  end

  def video_title
    video.title
  end

  def review?
    !video.reviews.find_by(user: user).blank?
  end
end

