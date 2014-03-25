class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :position, numericality: { only_integer: true }

  def review_rating
    review = Review.where(user: user, video: video).first
    review.rating if review
  end

  def review_rating=(new_rating)
    review = Review.where(user_id: user.id, video_id: video.id).first
    
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  def video_title
    video.title
  end

  def category_name
    video.category.name
  end
end