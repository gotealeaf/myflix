class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates :video_id, presence: true
  validates_uniqueness_of :video_id, scope: :user_id, message: "is already in queue"
  validates_numericality_of :position, only_integer: true, greater_than: 0

  def rating
    return review.rating if review
    nil
  end

  #virtual attribute - 
  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else 
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

end