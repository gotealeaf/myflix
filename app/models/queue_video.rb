class QueueVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :genre, to: :video
  delegate :name, to: :video, prefix: :video

  def rating
    review = video.reviews.where(user: user).first
    review.rating if !!review
  end

  def genre_name
    genre.name
  end
end
