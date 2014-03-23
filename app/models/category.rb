class Category < ActiveRecord::Base
  has_many :videos

  def recent_videos
    videos.reorder("created_at DESC").limit(6)
  end
end
