class Category < ActiveRecord::Base
  has_many :videos, order: :title

  def recent_videos
    Video.order(updated_at: :desc).where(category: self).first(6)
  end
end