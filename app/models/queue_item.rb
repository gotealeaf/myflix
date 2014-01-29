class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :name, to: :category, prefix: :category
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, only_integer: true
 
  def rating
    result = review.rating if review
  end

  def rating=(new_rating)
    if review 
      review.update_columns(rating: new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end
  end

  private

  def review
   @review = @review || Review.where(user_id: user.id, video_id: video.id ).last
  end

end
