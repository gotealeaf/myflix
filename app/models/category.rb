class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories, -> { order :title }, class_name: "Video"

  validates :name, presence: true, uniqueness: true
end