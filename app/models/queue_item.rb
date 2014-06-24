class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video


  def video_rating
    video_review = video.reviews.where(user = user)

    return "not rated" if video_review.empty?
  
    video_review.each do |review|
      return review.rating
    end
  end

  def category_name
    video.category.name
  end
end