class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :ranking

  def rating
    review = self.video.reviews.find_by_user_id(self.user_id)
    review ? review.rating : 0
  end
end