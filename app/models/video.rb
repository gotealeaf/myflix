class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    return [] if title.blank?
    where("title LIKE ?", "%#{title}%").order("created_at DESC") 
  end
  
end