class Category < ActiveRecord::Base
  has_many :videos, -> { order('created_at DESC') }

  validates :name, presence: true, uniqueness: true


  def recent_videos
    videos.first(6)
  end
end
