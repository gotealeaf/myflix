class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  validates :name, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end 