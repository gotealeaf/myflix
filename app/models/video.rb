class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items
  validates_presence_of :title, :description

  def self.search_by_title(search_string)
    return [] if search_string.blank?
    where('title LIKE ?', "%#{search_string}%").order("created_at DESC")
  end

  def average_rating
    self.reviews.empty? ? 0.0 : self.reviews.average('rating').round(1)
  end
end