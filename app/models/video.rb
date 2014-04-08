class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items
  validates_presence_of :title, :description

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def average_rating
    (total_rating_of_video / reviews_of_rating).round(1)
  end

  def total_rating_of_video
    reviews.select{ |review| review.rating.present? }.inject(0) { |total, review| total + review.rating }.to_f
  end

  def reviews_of_rating
    reviews.select{ |review| review.rating.present? }.count
  end
end
