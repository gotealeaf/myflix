class Category < ActiveRecord::Base
  has_many :videos, -> { order(updated_at: :desc) }
  validates :name, presence: true

  def recent_videos
    videos.first(6)
  end
end