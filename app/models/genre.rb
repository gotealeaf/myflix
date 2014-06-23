class Genre < ActiveRecord::Base
  has_many :videos, -> { order(:name) }
  validates :name, presence: true, uniqueness: true

  def recent_videos
    videos.reorder(created_at: :desc).limit(6)
  end
end
