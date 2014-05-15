class Video < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    return [] if title.blank?
    Video.where('title ilike ?', "%#{title}%").order(created_at: :desc)
  end
  
end
