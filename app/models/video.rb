class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}, uniqueness:true

  def self.search_by_title(search)
    return [] if search.blank?
    where("title LIKE ?", "%#{search}%").order("created_at DESC")
  end
end