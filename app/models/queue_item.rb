class QueueItem < ActiveRecord::Base
  belongs_to :creator, class_name: User, foreign_key: :user_id
  belongs_to :video

  def video_title
    video.title
  end

  def category
    video.category
  end

  def category_name
    category.name
  end

  def rating
    video.rating
  end
end
