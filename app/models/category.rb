class Category < ActiveRecord::Base
  has_many :videos

  def recent_videos
    videos.order("created_at DESC").first(6)
  end
end
