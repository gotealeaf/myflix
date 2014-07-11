class QueueVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates :position, numericality: { only_integer: true }
  validates_presence_of :position

  delegate :genre, to: :video
  delegate :name, to: :video, prefix: :video

  def rating
    review = video.reviews.where(user: user).first
    review.rating if !!review
  end

  def rating_present?
    !!video.reviews.find_by(user: user)
  end

  def genre_name
    genre.name
  end
end
