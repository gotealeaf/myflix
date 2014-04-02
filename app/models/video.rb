class Video < ActiveRecord::Base

  #has_many :queue_items
  has_many :video_categories
  has_many :categories, through: :video_categories, order: :name
  has_many :reviews, -> { order "created_at DESC" }

  #Validations
  validates :title,       presence: true#,
                          #length: { maximum: 30 }
  validates :description, presence: true

  def self.search_by_title(search_string)
    return [] if search_string.blank?
    where(["title LIKE ?", "%#{search_string}%"]).order(:created_at).reverse
  end

  def average_rating
    avg_video_rating = nil
    if self.reviews.any?
      sum_ratings = 0.0
      total_reviews = self.reviews.size
      self.reviews.each { |r| sum_ratings += r.rating }
      avg_video_rating = (sum_ratings/total_reviews).round(1)
    end
  end
end
