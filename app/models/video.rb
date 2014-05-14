class Video < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    Video.where('title like ?', "%#{title}%").order(created_at: :desc)
  end
  
end
