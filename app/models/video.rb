class Video < ActiveRecord::Base
  has_many :video_categories
  belongs_to :category
  has_many :reviews
  #video should not have many category in this project; however, I am lazy to fix this...
  validates_presence_of :title, :description

  has_many :reviews

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def number_of_reviews
    reviews.count
  end

  def averge_rating
    rating_data = self.reviews.map{ |i| i.rating }
    rating_data.sum.to_f / rating_data.count
  end

end
