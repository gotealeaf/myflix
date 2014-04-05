class Category < ActiveRecord::Base 
  # has_many :video_categories
  # has_many :videos, -> { order(:title) }, through: :video_categories
  has_many :videos

  validates_presence_of :name

  def self.recent_videos category
  	videos = Category.find(category).videos.sort{ |x, y| y.created_at <=> x.created_at }.take(6)
  end

end