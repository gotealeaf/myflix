class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id
  validates_numericality_of :position, only_integer: true

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_attribute(:rating, new_rating)
    else 
      Review.new(user_id: user.id, video_id: video.id, rating: new_rating).save(validate: false)   
    end
  end

  def category_name
    video.category.name
  end

  private

  def review
    @review ||= video.reviews.where(user = user).first
  end
end


