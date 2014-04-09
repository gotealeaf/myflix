class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_uniqueness_of :video, scope: :user

  def category_name
    video.category.name
  end

  def rating
    video.reviews.find_by(user: user).try(:rating)
  end

  def video_title
    video.title
  end
end

