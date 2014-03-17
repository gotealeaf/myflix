class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def video_title
    video.title
  end

  def category_name
    video.category.name
  end

  def video_rating
    review = video.reviews.where(user_id: user, video_id: video).first
    review.rating if review
  end
end