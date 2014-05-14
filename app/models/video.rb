class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}, uniqueness:true

  mount_uploader :small_cover, SmallCoverUploader
  mount_uploader :large_cover, LargeCoverUploader

  def self.search_by_title(search)
    return [] if search.blank?
    where('title ilike ?', "%#{search}%").order("created_at DESC")
  end

  def average_rating
    return '-' if reviews.count == 0
    reviews.average(:rating).round(1).to_s
  end
end