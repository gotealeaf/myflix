class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates :title, presence: true
  validates :description, presence: true




  def self.search_by_title(search_term)
    if search_term.blank? #use blank instead of empty bc empty includes "  "
      return []
    else
      where("title LIKE ?", "%#{search_term}%").order_by_created_at
    end
  end

  def average_review
    if self.reviews.count == 0
      return "N/A"
    else
      sum = 0
      self.reviews.each do |review|
        sum += review.rating
      end
      average = sum / self.reviews.count
    end
  end

  def self.order_by_created_at
    self.order("created_at DESC")
  end


end
