class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> {order( "created_at DESC" )}
  validates_presence_of :title, :description

  def self.search_by_title(key_word)
    return [] if key_word.blank?
    where("title LIKE ?", "%#{key_word}%").order("created_at DESC")
  end

  def rating
    if self.reviews.count == 0
      0
    else
      self.reviews.collect(&:rating).sum.to_f / self.reviews.count
    end
  end
end