class QueueVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates :position, numericality: { only_integer: true }
  validates_presence_of :position

  delegate :genre, to: :video
  delegate :name, to: :video, prefix: :video

  def rating
    review.rating if !!review
  end

  def rating=(select_rating)
    if review.present?
      review.update_attribute(:rating, select_rating)
    else
      review = Review.new(video: video, user: user, rating: select_rating)
      review.save(validate: false)
    end
  end

  def genre_name
    genre.name.titleize
  end

  private

  def review
    @review ||= video.reviews.find_by(user: user)
  end
end
