class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def rating
    reviews = Review.where(user_id: user_id, video_id: video_id)
    reviews.count > 0 ? reviews.first.rating : nil
  end
end
