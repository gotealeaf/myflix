class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates :video_id, presence: true
  validates_uniqueness_of :video_id, scope: :user_id, message: "is already in queue"
  validates_uniqueness_of :position, scope: :user_id

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    return review.rating if review
    "Unrated"
  end

  def category_name
    category.name
  end

end