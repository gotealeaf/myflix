class QueueItem < ActiveRecord::Base
belongs_to :video
belongs_to :user

delegate :title,      to: :video, prefix: :video
delegate :categories, to: :video, prefix: :video

validates :position, presence: true
validates :user_id,  presence: true
validates :video_id, presence: true

def user_rating
  review = Review.where(user_id: user.id, video_id: video.id).first
  review.rating if review
end

def video_category_names
  names_array = video_categories.each(&:name)
  names_array if names_array.any?
end

end
