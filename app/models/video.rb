class Video < ActiveRecord::Base
  belongs_to :category
  has_many :queue_items
  has_many :reviews, -> { order(created_at: :desc) }

  validates_presence_of :title, :description, :category_id

  mount_uploader :small_cover, SmallCoverUploader
  mount_uploader :large_cover, LargeCoverUploader

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def calculate_rating
    return "Be the first to rate this video!" if reviews.empty?
    
    total = 0.0
    reviews.each do |review|
      total += review.rating.to_f
    end
    total /= reviews.size
    total.round(1)
  end
end