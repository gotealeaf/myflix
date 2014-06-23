class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video


  def video_rating
    video_review = video.reviews.where(user = user)

    if video_review.empty?
      return "not rated"
    end
  
    video_review.each do |review|
      return review.rating
    end
  end

  def category_name
    video.category.name
  end
end