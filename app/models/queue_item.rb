class QueueItem < ActiveRecord::Base
  validates_numericality_of :position, { only_integer: true }

  belongs_to :user
  belongs_to :video

  # when you call .category, "delegate" will just tell rails to call .category on the video model instead of the QueueItem model
  delegate :category, to: :video
  #prefix makes the method name ".video_title" instead of ".title"
  delegate :title, to: :video, prefix: :video 

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
  end
end