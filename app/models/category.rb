class Category < ActiveRecord::Base
  has_many :videos, -> { order("title")}
  #has_many :videos, -> { order("created_at DESC")}

  def recent_videos
    #sort in reverse order, get 6 most recent
    #found_videos = videos.sort{|b,a| a.created_at <=> b.created_at}[0..5]
    found_videos = videos[0..5]
  end
end
