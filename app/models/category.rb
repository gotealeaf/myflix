class Category < ActiveRecord::Base
  require 'pry'
  has_many :videos
  validates :name, presence: true

  def self.recent_video(category)
    category.videos.order(created_at: :desc).limit(6)
  end
end