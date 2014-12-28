class Category < ActiveRecord::Base
	has_many :video_categories
	has_many :videos, -> { order 'title' }, through: :video_categories

  def recent_videos
    @recent_videos = videos.order(created_at: :desc).take(6)
  end
end