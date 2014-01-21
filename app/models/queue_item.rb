class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  
  validates_numericality_of :position, { only_integer: true }
  
  def rating 
    review.rate if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rate, new_rating)
    else 
      review = Review.new(user: user, video: video, rate: new_rating)
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
