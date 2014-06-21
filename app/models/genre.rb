class Genre < ActiveRecord::Base
  has_many :videos, ->{order(:name)}
  validates :name, presence: true, uniqueness: true
  #validates :slug, uniqueness: true

  def recent_videos
    videos.order(created_at: :desc).limit(6)
  end

  def to_param
    self.slug
  end
end
