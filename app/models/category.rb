class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories, order: "created_at DESC"

  # Validations
  validates :name, presence: true#,
                   #length: { maximum: 30 }

  def recent_videos
    self.videos.limit(6)
  end
end
