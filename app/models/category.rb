class Category < ActiveRecord::Base
  #has_many :videos, -> { order('created_at asc') }
  #above code will top the order in the recent_videos
  has_many :videos
  validates_presence_of :name
  validates_uniqueness_of :name

  def recent_videos
    self.videos.order(created_at: :desc).first(6)
  end
end
