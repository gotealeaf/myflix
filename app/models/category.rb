class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories

  def recent_videos
    videos.order("created_at DESC").first(6)
  end
end
