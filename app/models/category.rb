class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, -> { order("created_at DESC") }, through: :video_categories

  # Validations
  validates :name, presence: true#,
                   #length: { maximum: 30 }

  def recent_videos
    self.videos.limit(6)
  end
end
