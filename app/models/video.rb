class Video < ActiveRecord::Base
	belongs_to :category
  has_many :reviews, -> { order('created_at DESC') } 
  has_many :que_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%")
  end

  def recent_reviews
    reviews.limit(8)
  end

  def average_rating
    if reviews.empty?
      nil
    else    
      collection = reviews.select(:rating).map {|r| r.rating}
      collection.sum / collection.count
    end
  end

end