class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> {order "created_at desc"}
  
  validates_presence_of :title, :description
  
  def self.search_by_title(title)
    return [] if title.blank?
    Video.where('title ilike ?', "%#{title}%").order(created_at: :desc)
  end
  
  def average_rating
    return '' if reviews.count == 0
    reviews.average(:rating).round(1).to_s
  end
  
end
