class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories
  has_many :reviews, -> {  order 'created_at desc' }
  has_many :my_queue_videos

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 5}


  def self.search(query)
    return [] if query.blank?
    where('title   LIKE ?', "%#{query}%").order('title DESC')
  end

  def rating
    return  0 if reviews.size == 0
    reviews.sum(:rating) / reviews.size
  end

  def nr_of_reviews
    reviews.size
  end
end 