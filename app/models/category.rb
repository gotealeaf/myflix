class Category < ActiveRecord::Base
	has_many :video_categories
	has_many :videos, -> { order 'title' }, through: :video_categories

  def recent_videos
    
    @recent_videos = videos.reorder('created_at DESC').take(6)
  end
end