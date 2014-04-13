class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :user, presence: true
  validates :video, presence: true, uniqueness: { scope: :user_id }
  validates :position, allow_blank: true, numericality: { only_integer: true }

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def category_name
    category.name
  end

  def rating
    review = video.reviews.find_by(user: user)
    review.rating if review
  end
end