class Video < ActiveRecord::Base

  has_many :video_categories
  has_many :categories, -> { order("name") }, through: :video_categories
  has_many :reviews, -> { order("created_at DESC") }

  # Mount uploaders to control file upload
  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  # Validations
  validates :title,       presence: true
  validates :description, presence: true
  validates :video_url,   presence: true

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
