class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order('created_at desc') }
  has_many :queue_items

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('title LIKE ?', "%#{search_term}%").order('created_at DESC') 
  end

  def average_rating
    return 0 if self.reviews.empty?
    self.reviews.average(:rating).round(1)
  end
end
