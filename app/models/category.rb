class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories, order: "created_at DESC"

  def recent_videos
    videos.first(6)
  end
end