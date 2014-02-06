class Category < ActiveRecord::Base

  has_many :videos, -> {order("created_at DESC")}

  def recent_videos
    videos.first(6)
  end

  def remaining_videos
    # initial_videos = self.recent_videos
    # videos - initial_videos
    videos - self.recent_videos
  end
end
