class Category < ActiveRecord::Base
  has_many :videos

  def recent_videos
    self.videos.order("created_at DESC").limit(6).to_a
  end
end