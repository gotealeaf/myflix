class Category < ActiveRecord::Base
  require 'pry'
  has_many :videos
  validates :name, presence: true

  def self.recent_video(category)
    #Video.last(6).reverse
    category.videos.order(created_at: :desc).limit(6)
  end
end