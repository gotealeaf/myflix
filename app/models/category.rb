class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC")}
  validates_presence_of :name

  def video_title
    video.video
  end

  def recent_videos
    videos.first(6)
  end

end