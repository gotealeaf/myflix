class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items
  validates_presence_of :title, :description

  def self.search_by_title(search_string)
    return [] if search_string.blank?
    where('title LIKE ?', "%#{search_string}%").order("created_at DESC")
  end

  def average_rating
    ratings = reviews.map(&:rating) - [nil]
    average_rating = ratings.inject(:+).to_f / ratings.count
    reviews.empty? ? 0.0 : average_rating.round(1)
  end

  def reviewed?(user)
    !!reviews.where(user: user).first
  end

  def on_queue?(user)
    !!queue_items.where(user: user).first
  end
end