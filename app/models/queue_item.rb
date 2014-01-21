class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :name, to: :category, prefix: :category
  delegate :title, to: :video, prefix: :video


  validates_numericality_of :position, only_integer: true
 
  def rating
    review = Review.where(user_id: user.id, video_id: video.id )
    result = review.first.rating unless review.empty?
  end

end
