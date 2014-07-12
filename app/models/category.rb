class Category < ActiveRecord::Base
  has_many :videos
  
  def recent_videos
    @videos_sorted = self.videos.sort_by { |video| video.created_at}.reverse
    if @videos_sorted.size < 6
      return @videos_sorted
    else
      return @videos_sorted.first(6)
    end
  end


end
