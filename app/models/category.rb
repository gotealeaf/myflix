class Category < ActiveRecord::Base
  has_many :videos

  validates_presence_of :name

  def recent_videos
    self.videos.order(created_at: :desc).limit(6)
  end
end
