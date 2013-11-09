class Video < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :category
  
  def self.search_by_name(search_term)
    return [] if search_term.empty?
    where("name like ?", "%#{search_term}%")
  end
end