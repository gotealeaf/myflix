class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews, -> { order("created_at DESC") } #latest reviews will be shown first
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    return [] if title.blank?
    where("title #{DATABASE_OPERATOR[:like_operator]} ?", "%#{title}%").order("created_at DESC") 
  end
  
  def recent_videos
    self.sort_by(&:created_at).reverse
  end
 
  def average_rating
    reviews.blank? ? 0 : reviews.average(:rating).to_f.round(1)
  end
  
end