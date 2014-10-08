class Category < ActiveRecord::Base
  
  has_many :video_categories
  has_many :videos, through: :video_categories
  
  validates_presence_of :name
  
  def show_recent
    self.videos.order(created_at: :desc).limit(6)
  end
  
end