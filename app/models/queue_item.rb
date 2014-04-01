class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates :position, numericality: { only_integer: true }

  def review_rating
    review.rating.to_i if review
  end

  def review_rating=(new_rating)
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