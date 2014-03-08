class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  #video should not have many category in this project; however, I am lazy to fix this...
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end
