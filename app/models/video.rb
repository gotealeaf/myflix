class Video < ActiveRecord::Base
  
  has_many :video_categories
  has_many :categories, through: :video_categories
  
  validates_presence_of :title, :description
  
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title like ?", "%#{search_term}%").order("title")
  end
  
end