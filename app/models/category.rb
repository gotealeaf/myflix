class Category < ActiveRecord::Base
  has_many :videos, -> { order(created_at: :desc) }   # { order(title: :asc ) }

  validates :name, presence: true, uniqueness: true

  def recent_videos
    videos.first(6) 
  end
end  