class Video < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :category
  scope :recent, :limit => 6, :order => 'created_at DESC'
  
  def self.search_by_name(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%")
  end
end