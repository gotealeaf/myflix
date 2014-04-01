class QueueItem < ActiveRecord::Base
belongs_to :video
belongs_to :user

delegate :title,      to: :video, prefix: :video
delegate :categories, to: :video, prefix: :video

def user_rating
  review = Review.where(user_id: user.id, video_id: video.id).first
  review.rating if review
end

end
