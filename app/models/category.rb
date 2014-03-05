class Category < ActiveRecord::Base
  has_many :videos, -> { order "title ASC" }
  validates_presence_of :title, :description

  def display_most_recent_videos
    videos.reorder("created_at DESC").take(6)
  end
end
