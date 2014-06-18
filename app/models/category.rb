class Category < ActiveRecord::Base
 has_many :videos, order: "created_at DESC"

validates_uniqueness_of :category
 def recent_videos
  videos.first(6)
 end
end