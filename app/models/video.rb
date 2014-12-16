class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 5}

  def self.search(query)
    return [] if query.blank?
    where('title   LIKE ?', "%#{query}%").order('title DESC')
  end
end