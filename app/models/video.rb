class Video < ActiveRecord::Base
	belongs_to :category
  has_many :reviews, -> { order('created_at DESC') } 
  has_many :ques

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%")
  end

  def recent_reviews
    reviews.limit(8)
  end

  def average_rating    
    collection = reviews.select(:rating).map {|r| r.rating}
    collection.inject{ |sum, el| sum + el }.to_f / collection.size
  end

end