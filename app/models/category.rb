class Category < ActiveRecord::Base
  has_many :videos

  def recent_videos
    self.videos.limit(6).order("created_at DESC")
  end
end