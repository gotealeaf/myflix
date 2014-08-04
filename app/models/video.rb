class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader
  
  validates :title, presence: :true, uniqueness: true
  validates :description, presence: true 

  def self.search_by_title title
  	return [] if title.blank?
      	
  	where("title LIKE ?", "%#{title}%").order("created_at DESC")
  end

  def rating
    if reviews.count > 0
      sum_ratings = 0
      count_ratings = 0

      reviews.each do |review|
        sum_ratings += review.rating.to_f
        count_ratings += 1.to_f
      end

      (sum_ratings / count_ratings).round(1)
    else
      nil
    end
  end
end