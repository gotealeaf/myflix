class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }
  validates :name, presence: true

  def recent_videos
    videos.limit(6)
  end
end