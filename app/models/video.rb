class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, order: :name, through: :video_categories

  validates :title, presence: :true, uniqueness: true
  validates :description, presence: true 
end