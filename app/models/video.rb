class Video < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :category
	has_many :reviews

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%")
  end
end