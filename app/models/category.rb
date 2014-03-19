class Category < ActiveRecord::Base
  has_many :videos, order: :title

  def recent_videos
    videos = Video.where(category: self)
  end
end