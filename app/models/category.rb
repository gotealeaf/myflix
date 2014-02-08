class Category < ActiveRecord::Base

  has_many :videos, -> {order("created_at DESC")}

  def recent_videos
    videos.first(6)
  end

  def remaining_videos
     remainder = self.videos - self.recent_videos
     remainder.sort_by(&:title)
  end
end
