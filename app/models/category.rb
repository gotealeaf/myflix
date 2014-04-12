class Category < ActiveRecord::Base 
  has_many :videos

  validates_presence_of :name

  def self.recent_videos category
  	Category.find(category).videos.order('created_at DESC').take(6)
  end
end