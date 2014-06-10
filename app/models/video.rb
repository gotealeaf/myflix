class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews, -> { order("created_at DESC") } #latest reviews will be shown first
  has_many :queue_items
  
  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    return [] if title.blank?
    where("title #{DATABASE_OPERATOR[:like_operator]} ?", "%#{title}%").order("created_at DESC") 
  end
  
  def recent_videos
    self.sort_by(&:created_at).reverse
  end
 
def rating
    reviews.average(:rating).to_f.round(1) if reviews.average(:rating)
  end
  
end