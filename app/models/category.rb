class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, -> { order :title }, through: :video_categories

  validates :name, presence: true, uniqueness: true

  def recent_videos
    return [] if videos.empty?
    videos.sort_by { |video| video.created_at }.reverse.take(6)
  end
end