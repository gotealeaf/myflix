class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?

    self.where('lower(title) LIKE :search_string', search_string: '%' + title.to_s.downcase + '%').
        order(created_at: :desc)
  end

  def average_rating
     (total_reviews_rating / reviews_count).round(1)
  end

  private

  def total_reviews_rating
     self.reviews.inject(0) { |sum, review| sum + review.rating }.to_f
  end

  def reviews_count
    self.reviews.count
  end
end
