class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
   validates_numericality_of :position, :greater_than => 0, :only_integer => :true

  def rating
    reviews = Review.where(user_id: user_id, video_id: video_id)
    reviews.count > 0 ? reviews.first.rating : nil
  end
end
