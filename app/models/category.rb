class Category < ActiveRecord::Base
  #has_many :video_categories
  #has_many :videos, -> { distinct }, through: :video_categories
  has_many :videos, -> { order(:title) }
  validates :name, presence: true, uniqueness: true

  def recent_videos
    Video.where(category_id: self.id).order('created_at DESC').first(6)
  end
end
