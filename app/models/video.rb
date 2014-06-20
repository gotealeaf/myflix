class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, order: "created_at DESC"

  validates :title, :description, presence: true

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def calculate_rating
    if reviews.empty?
      return "Be the first to rate this video!"
    end
    total = 0.0
    reviews.each do |review|
      total += review.rating.to_f
    end
    total /= reviews.size
    total.round(1)
  end
end